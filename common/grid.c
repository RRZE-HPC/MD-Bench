#include <stdio.h>
#include <grid.h>
#include <mpi.h>
#include <parameter.h>
#include <allocate.h>
#include <util.h>
#include <math.h>

static MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE;

//Grommacs Balancing
MD_FLOAT f_normalization(MD_FLOAT* x,MD_FLOAT* fx, MD_FLOAT minx, int nprocs) {

  MD_FLOAT sum=0;
  for(int i = 0; i<nprocs; i++){
    fx[i] = MAX(minx,x[i]);
    sum+=fx[i];
  }

  for(int i = 0; i<nprocs; i++)
    fx[i] /= sum;    
}

void fixedPointIteration(MD_FLOAT* x0, int nprocs, MD_FLOAT minx)
{
  MD_FLOAT tolerance = 1e-6;
  MD_FLOAT alpha = 0.5;
  MD_FLOAT *fx = (MD_FLOAT*) malloc(nprocs*sizeof(MD_FLOAT));
  int maxIterations = 100; 

  for (int i = 0; i < maxIterations; i++) {

    int converged = 1; 
    f_normalization(x0,fx,minx,nprocs);

    for(int n=0; n<nprocs; n++)
      fx[i]= (1-alpha) * x0[i] + alpha * fx[i];
     
    for (int i = 0; i < nprocs; i++) {
        if (fabs(fx[i] - x0[i]) >= tolerance) {
            converged = 0;
            break;
        }      
    }
    if(converged) return;

    for (int i = 0; i < nprocs; i++) 
        x0[i] = fx[i];
  }
}

void staggeredBalance(Grid* grid, Atom* atom, Parameter* param, double newTime)
{ 
  int me;
  MPI_Comm_rank(MPI_COMM_WORLD, &me);
  int *coord = grid->coord;
  int *nprocs  = grid ->nprocs;
  //Elapsed time since the last rebalance
  double time = newTime - grid->Timer;
  grid->Timer = newTime;
  //Define parameters
  MPI_Comm subComm[3]; 
  int color[3] = {0,0,0};
  int id[3] = {0,0,0};
  MD_FLOAT ** load = (MD_FLOAT**) malloc(3*sizeof(MD_FLOAT*));
  for(int dim = 0; dim<3; dim++) 
    load[dim] = (MD_FLOAT*) malloc(nprocs[dim]*sizeof(MD_FLOAT));
 
  int maxprocs = MAX(MAX(nprocs[_x],nprocs[_y]),nprocs[_z]);
  MD_FLOAT* cellSize = (MD_FLOAT*) malloc(maxprocs*sizeof(MD_FLOAT)); 
  MD_FLOAT* limits = (MD_FLOAT*) malloc(2*maxprocs*sizeof(MD_FLOAT)); //limits: (x0, x1), (x1, x2)... Repeat values in between to perfom MPI_Scatter later 
  MD_FLOAT t_sum[3] = {0,0,0}; 
  MD_FLOAT recv_buf[2] = {0,0};        //Each proc only receives 2 elments per dimension xlo and xhi
  MD_FLOAT balancedLoad[3] = {0,0,0};  //1/nprocs
  MD_FLOAT minLoad[3]  = {0,0,0};      //beta*(1/nprocs) 
  MD_FLOAT prd[3] = {param->xprd, param->yprd, param->zprd};
  MD_FLOAT boundaries[6] ={0,0,0,0,0,0}; // xlo,xhi,ylo,yhi,zlo,zhi

  //Create sub-communications along each dimension
  for(int dim = 0; dim<3; dim++){
     if(dim == _x){
        color[_x] = (coord[_y] == 0 && coord[_z] ==0) ? 1:MPI_UNDEFINED;
        id[_x] = me;
     } else if(dim == _y) {
        color[_y] = coord[_z] == 0 ? coord[_x]:MPI_UNDEFINED; 
        id[_y] = (coord[_y] == 0 && coord[_z] == 0) ? 0:me;
     } else {
        color[_z]= coord[_y]*nprocs[_x]+coord[_x]; 
        id[_z] = coord[_z] == 0 ? 0 : me; 
     }
    MPI_Comm_split(world, color[dim], id[dim], &subComm[dim]);
  } 

  //Set the minimum load and the balance load
  for(int dim = 0; dim<3; dim++){
    balancedLoad[dim] = 1./nprocs[dim]; 
    minLoad[dim]  = 0.8*balancedLoad[dim]; 
  }
  //set and communicate the workload in reverse order
  for(int dim = _z; dim>= _x; dim--)
  {
    MPI_Gather(&time,1,type,load[dim],1,type,0,subComm[dim]);

    if(id[dim] == 0)
    {
      for(int i=0; i<nprocs[dim]; i++) 
        t_sum[dim] += load[dim][i];

      for(int i=0; i<nprocs[dim]; i++)
        load[dim][i] /= t_sum[dim];
    }

    time =t_sum[dim];
    
    MPI_Barrier(world);
  }
  //Brodacast the new boundaries along dimensions
  for(int dim=0; dim<3; dim++){
    MPI_Bcast(boundaries,6,type,0,subComm[dim]);
    if(id[dim] == 0) {
      fixedPointIteration(load[dim], nprocs[dim], minLoad[dim]); 
      MD_FLOAT product=1;
      for(int i=0; i<nprocs[dim];i++)
        product *=load[dim][i];
      
      for(int i=0; i<nprocs[dim];i++)
        cellSize[i] = (product/load[dim][i])*prd[dim]; 

      MD_FLOAT sum=0;
      for(int i=0; i<nprocs[dim]; i++){
        limits[2*i] = sum; 
        limits[2*i+1] = sum+cellSize[i];
        sum+= cellSize[i]; 
      }
      limits[2*nprocs[dim]-1] = prd[dim];
    } 
    MPI_Scatter(limits,2,type,recv_buf,2,type,0,subComm[dim]); 
    boundaries[2*dim] = recv_buf[0];
    boundaries[2*dim+1] = recv_buf[1];
    MPI_Barrier(world);
  }  

  atom->mybox.lo[_x]=boundaries[0]; atom->mybox.hi[_x]=boundaries[1];
  atom->mybox.lo[_y]=boundaries[2]; atom->mybox.hi[_y]=boundaries[3];
  atom->mybox.lo[_z]=boundaries[4]; atom->mybox.hi[_z]=boundaries[5];
 
  MD_FLOAT domain[6] = {boundaries[0], boundaries[2], boundaries[4], boundaries[1], boundaries[3], boundaries[5]};
  MPI_Allgather(domain, 6, type, grid->map, 6, type, world);
  for(int dim=0; dim<3; dim++) {
    MPI_Comm_free(&subComm[dim]);
    free(load[dim]);
  }
  free(load); 
  free(limits); 
}

//RCB Balancing
MD_FLOAT meanTimeBisect(Atom *atom, MPI_Comm subComm, int dim, double time)
{
  MD_FLOAT sum=0, mean=0, weightAtoms = 0;

  for(int i=0; i<atom->Nlocal; i++){
    sum += atom_pos(i);
  }
  sum*=time;
  weightAtoms = atom->Nlocal*time;
   
  MPI_Allreduce(&sum, &sum, 1, type, MPI_SUM, subComm);
  MPI_Allreduce(&weightAtoms, &weightAtoms, 1, type, MPI_SUM, subComm);
  mean = sum/weightAtoms;
  return mean;
}

MD_FLOAT meanBisect(Atom* atom, MPI_Comm subComm, int dim, double time)
{  
  int Natoms = 0;
  MD_FLOAT sum=0, mean=0;

  for(int i=0; i<atom->Nlocal; i++){
    sum += atom_pos(i);
  }

  MPI_Allreduce(&sum, &sum, 1, type, MPI_SUM, subComm);
  MPI_Allreduce(&atom->Nlocal, &Natoms, 1, type, MPI_SUM, subComm);
  mean = sum/Natoms;
  return mean;
} 

void nextBisectionLevel(Grid* grid, Atom* atom, RCB_Method method, MPI_Comm subComm, int dim ,int* color, int ilevel, double newTime)
{ 
  int rank, size;
  int branch = 0, i = 0, m = 0;
  int nsend = 0, nrecv = 0, nrecv2 = 0;
  int values_per_atom = 7; 
  MD_FLOAT bisection, pos;
  MPI_Request request[2] = {MPI_REQUEST_NULL,MPI_REQUEST_NULL};
  MPI_Comm_rank(subComm,&rank);
  MPI_Comm_size(subComm,&size);

  int half = (int) (0.5*size);
  int partner = (rank<half) ? rank+half:rank-half;
  int odd = size%2;
  int extraProc = size-1;

  //Apply the bisection 
  double time = newTime - grid->Timer;
  grid->Timer = newTime;
  bisection = method(atom,subComm,dim,time);
  //Define the new boundaries
  if(rank<half){
    atom->mybox.hi[dim] = bisection;
    branch = 0;
  } else {
    atom->mybox.lo[dim] = bisection;
    branch = 1;
  }
  //Define new color for the further communicaton
  *color = (branch << ilevel) | *color;

  //Grow the send buffer
  if(atom->Nlocal>=grid->maxsend){
      if(grid->buf_send) free(grid->buf_send); 
      grid->buf_send = (MD_FLOAT*) malloc(atom->Nlocal*values_per_atom* sizeof(MD_FLOAT));
      grid->maxsend = atom->Nlocal;
  }
  
  //buffer particles to send
  while(i < atom->Nlocal) {
    pos = atom_pos(i);
    if(pos < atom->mybox.lo[dim] || pos >= atom->mybox.hi[dim]) {
      nsend += packExchange(atom, i, &grid->buf_send[nsend]);
      copy(atom, i, atom->Nlocal-1);
      atom->Nlocal--;
    } else i++;
  }

  //Communicate the number of elements to be sent
  MPI_Irecv(&nrecv,1,MPI_INT,partner,0,subComm,&request[0]);
  MPI_Send(&nsend,1,MPI_INT,partner,0,subComm);
  
  if(odd){ 
    if(rank == 0)
      MPI_Irecv(&nrecv2,1,MPI_INT,extraProc,0,subComm,&request[1]);
    if(rank == extraProc)
      MPI_Send(&nsend,1,MPI_INT,0,0,subComm);     
  }
  MPI_Waitall(2,request,MPI_STATUS_IGNORE);

  //Grow the recv buffer 
  if(nrecv+nrecv2>=grid->maxrecv){
      if(grid->buf_recv) free(grid->buf_recv); 
      grid->buf_recv = (MD_FLOAT*) malloc((nrecv+nrecv2)*values_per_atom*sizeof(MD_FLOAT));
      grid->maxrecv = nrecv+nrecv2;
  }
  //communicate elements in the buffer
  MPI_Irecv(grid->buf_recv,nrecv,type,partner,0,subComm,&request[0]);
  MPI_Send (grid->buf_send,nsend,type,partner,0,subComm); 
  
  if(odd){   
    if(rank == 0)
      MPI_Irecv(&grid->buf_recv[nrecv],nrecv2,type,extraProc,0,subComm,&request[1]);
    if(rank == extraProc)
      MPI_Send(grid->buf_send,nsend,type,0,0,subComm);
  }
  MPI_Waitall(2,request,MPI_STATUS_IGNORE);
  //store atoms in atom list
  while(m < nrecv){ 
    m += unpackExchange(atom, atom->Nlocal++, &grid->buf_recv[m]);
  }
}

void rcbBalance(Grid* grid, Atom* atom, Parameter* param, RCB_Method method, int ndim, double time)
{
  int me, nprocs=0, ilevel=0, nboxes=1;
  int color = 0, size =0;
  int index, prd[3];
  MPI_Comm subComm;
  MPI_Comm_size(world, &nprocs);
  MPI_Comm_rank(world, &me);

  prd[_x] = atom->mybox.xprd = param->xprd; 
  prd[_y] = atom->mybox.yprd = param->yprd; 
  prd[_z] = atom->mybox.zprd = param->zprd;

  //Sort by larger dimension 
  int largerDim[3] ={_x, _y, _z};

  for(int i = 0; i< 2; i++){
    for(int j = i+1; j<3; j++)
    {
      if(prd[largerDim[j]]>prd[largerDim[i]]){
        MD_FLOAT tmp = largerDim[j];
        largerDim[j] = largerDim[i];
        largerDim[i] = tmp;
      }  
    }
  }
  //Initial Partition
  atom->mybox.lo[_x] = 0; atom->mybox.hi[_x] = atom->mybox.xprd;
  atom->mybox.lo[_y] = 0; atom->mybox.hi[_y] = atom->mybox.yprd;
  atom->mybox.lo[_z] = 0; atom->mybox.hi[_z] = atom->mybox.zprd;
  
  //Recursion tree 
  while(nboxes<nprocs)
  {  
    index = ilevel%ndim; 
    MPI_Comm_split(world, color, me, &subComm);
    MPI_Comm_size(subComm,&size);
    if(size > 1){
      nextBisectionLevel(grid, atom, method, subComm, largerDim[index], &color, ilevel, time);
    }
    MPI_Comm_free(&subComm);
    nboxes = pow(2,++ilevel);
  }
  //Creating the global map
  MD_FLOAT domain[6] = {atom->mybox.lo[_x], atom->mybox.lo[_y], atom->mybox.lo[_z], atom->mybox.hi[_x], atom->mybox.hi[_y], atom->mybox.hi[_z]};
  MPI_Allgather(domain, 6, type, grid->map, 6, type, world);  
}

//Regular grid
void cartisian3d(Grid* grid, Parameter* param, Box* box)
{
  int me, nproc;
  MPI_Comm_size(MPI_COMM_WORLD, &nproc);
  MPI_Comm_rank(MPI_COMM_WORLD, &me);
  
  int numdim=3;
  int reorder=0;
  int periods[3]={1,1,1}; 
  int mycoord[3]={0,0,0};
  int griddim[3]={0,0,0};
  MD_FLOAT len[3];
  MPI_Comm cartesian;

  box->xprd = param->xprd;
  box->yprd = param->yprd;
  box->zprd = param->zprd;

 //Creates a cartesian 3d grid 
  MPI_Dims_create(nproc, numdim, griddim); 
  MPI_Cart_create(world,numdim,griddim,periods,reorder,&cartesian); 
  grid->nprocs[_x] = griddim[_x];
  grid->nprocs[_y] = griddim[_y]; 
  grid->nprocs[_z] = griddim[_z];

  //Coordinates position in the grid
  MPI_Cart_coords(cartesian,me,3,mycoord); 
  grid->coord[_x] = mycoord[_x];
  grid->coord[_y] = mycoord[_y];
  grid->coord[_z] = mycoord[_z];
 
  //boundaries of my local box, with origin in (0,0,0). 
  len[_x] = param->xprd / griddim[_x];
  len[_y] = param->yprd / griddim[_y];
  len[_z] = param->zprd / griddim[_z];

  box->lo[_x] = mycoord[_x] * len[_x];
  box->hi[_x] = (mycoord[_x] + 1) * len[_x];
  box->lo[_y] = mycoord[_y] * len[_y];
  box->hi[_y] = (mycoord[_y] + 1) * len[_y];
  box->lo[_z] = mycoord[_z] * len[_z];
  box->hi[_z] = (mycoord[_z] + 1) * len[_z];
  
  MD_FLOAT domain[6] = {box->lo[_x], box->lo[_y], box->lo[_z], box->hi[_x], box->hi[_y], box->hi[_z]};
  MPI_Allgather(domain, 6, type, grid->map, 6, type, world);
  MPI_Comm_free(&cartesian);
}

//Other Functions from the grid
void initGrid(Grid* grid)
{ //start with regular grid
  int me, nprocs;
  MPI_Comm_size(world, &nprocs);
  MPI_Comm_rank(world, &me);
  grid->map_size = 6 * nprocs;             
  grid->map  = (MD_FLOAT*) allocate(ALIGNMENT, grid->map_size * sizeof(MD_FLOAT));  
  //========rcb=======
  grid->maxsend = 0; 
  grid->maxrecv = 0;
  grid->buf_send = NULL;  
  grid->buf_recv = NULL;
  //====staggered=====
  grid->Timer = 0;
}

void setupGrid(Grid* grid, Atom* atom, Parameter* param)
{
  int me; 
  MD_FLOAT xlo, ylo, zlo, xhi, yhi, zhi; 
  MPI_Comm_rank(MPI_COMM_WORLD, &me);
  initGrid(grid);

  //Set the origin at (0,0,0)
  if(param->input_file){
    for(int i=0; i<atom->Nlocal; i++){
      atom_x(i) = atom_x(i) - param->xlo;
      atom_y(i) = atom_y(i) - param->ylo;
      atom_z(i) = atom_z(i) - param->zlo;
    }
  }

  cartisian3d(grid, param, &atom->mybox);
  
  xlo = atom->mybox.lo[_x]; xhi = atom->mybox.hi[_x];  
  ylo = atom->mybox.lo[_y]; yhi = atom->mybox.hi[_y];
  zlo = atom->mybox.lo[_z]; zhi = atom->mybox.hi[_z];  

  int i = 0; 
  while(i < atom->Nlocal) 
  {
    if(atom_x(i) >= xlo && atom_x(i)< xhi &&  
       atom_y(i) >= ylo && atom_y(i)< yhi &&  
       atom_z(i) >= zlo && atom_z(i)< zhi)
      {
        i++;
      } else {
        copy(atom, i, atom->Nlocal-1);
        atom->Nlocal--; 
      }
  } 

  if(!param->balance){
    MPI_Allreduce(&atom->Nlocal, &atom->Natoms, 1, MPI_INT, MPI_SUM, world); 
    printf("Processor:%i, Local atoms:%i, Total atoms:%i\n",me, atom->Nlocal,atom->Natoms);
    MPI_Barrier(world);
  }  
}

void printGrid(Grid* grid)
{
  int me, nprocs;
  MPI_Comm_size(world, &nprocs);
  MPI_Comm_rank(world, &me);
  MD_FLOAT* map = grid->map;
  if(me==0)
  {
    printf("=====================================\n");
    printf("                GRID                 \n");
    printf("=====================================\n");
    for(int i=0; i<nprocs; i++)
      printf("Box processor:%i\n xlo:%.4f\txhi:%.4f\n ylo:%.4f\tyhi:%.4f\n zlo:%.4f\tzhi:%.4f\n", i,map[6*i],map[6*i+3],map[6*i+1],map[6*i+4],map[6*i+2],map[6*i+5]);
    printf("=====================================\n");
  }
  MPI_Barrier(world);
}



