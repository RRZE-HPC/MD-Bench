#include <stdio.h>
#include <grid.h>
#include <mpi.h>
#include <parameter.h>
#include <allocate.h>
#include <util.h>
#include <math.h>

static MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE;
static enum {_xlo=0, _ylo, _zlo, _xhi, _yhi, _zhi};

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

void staggeredBalance(Grid* grid, Atom* atom, Parameter* param, double t2)
{ 
  int me;
  MPI_Comm_rank(MPI_COMM_WORLD, &me);
  int *coord = grid->coord;
  int *nprocs  = grid ->nprocs;
  double time = t2 - grid->Timer;
  
  MPI_Comm subComm[3]; 

  int color[3] = {-1,-1,-1};
  int id[3] = {-1,-1,-1};
  MD_FLOAT* load_x = (MD_FLOAT*) malloc(nprocs[_x]*sizeof(MD_FLOAT));
  MD_FLOAT* load_y = (MD_FLOAT*) malloc(nprocs[_y]*sizeof(MD_FLOAT));
  MD_FLOAT* load_z = (MD_FLOAT*) malloc(nprocs[_z]*sizeof(MD_FLOAT));
  MD_FLOAT* load[3] = {load_x, load_y, load_z};

  for(int dim = 0; dim<3; dim++){
     if(dim == _x){
        color[_x] = (coord[_y] == 0 && coord[_z] ==0) ? 1:-1;
        id[_x] = me;
     } else if(dim == _y) {
        color[_y] = coord[_z] == 0 ? coord[_x]:-1; 
        id[_y] = (coord[_y] == 0 && coord[_z] == 0) ? 0:me;
     } else {
        color[_z]= coord[_y]*nprocs[_x]+coord[_x]; 
        id[_z] = coord[_z] == 0 ? 0 : me; 
     }
    printf("color:%i, id:%i,dim:%i\n",color[dim],id[dim],dim);
    MPI_Comm_split(MPI_COMM_WORLD, color[dim], id[dim], &subComm[dim]);
  } 
 
  int maxprocs = MAX(MAX(nprocs[_x],nprocs[_y]),nprocs[_z]);
  MD_FLOAT* cellSize = (MD_FLOAT*) malloc(maxprocs*sizeof(MD_FLOAT)); 
  MD_FLOAT* limits = (MD_FLOAT*) malloc(2*maxprocs*sizeof(MD_FLOAT)); //limits: x0, x1, x1, x2, x2, x3, x3 , . . ,xn
  MD_FLOAT t_sum[3] = {0,0,0}; 
  MD_FLOAT recv_buf[2] = {0,0}; 
  MD_FLOAT desiredLoad[3] = {0,0,0};  //1/nprocs
  MD_FLOAT minLoad[3]  = {0,0,0};     //beta*(1/nprocs) 
  MD_FLOAT prd[3] = {param->xprd, param->yprd, param->zprd};
  int boundaries[6] ={0,0,0,0,0,0}; //
   
  for(int dim = 0; dim<3; dim++){
    desiredLoad[dim] = 1./nprocs[dim]; 
    minLoad[dim]  = 0.8*desiredLoad[dim]; 
  }

  for(int dim = 2; dim>=0; dim--)
  {
    if(color[dim]>=0)
    { 
      MPI_Gather(&time,1,type,load[dim],1,type,0,subComm[dim]);
    }
    if(id[dim] == 0)
    {
      for(int i=0; i<nprocs[dim]; i++) 
        t_sum[dim] += load[dim][i];
      for(int i=0; i<nprocs[_z]; i++)
        load[dim][i] /= t_sum[_z];
    }
    MPI_Barrier(world);
  }
  
  for(int dim=0; dim<3; dim++){
    if(id[dim] == 0) {
      MPI_Bcast(boundaries,6,type,0,subComm[dim]);
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

      MPI_Scatter(limits,2,type,recv_buf,2,type,0,subComm[dim]); 
    } 
    boundaries[2*dim] = recv_buf[0];
    boundaries[2*dim+1] = recv_buf[1];
    MPI_Barrier(world);
  }  
  
  atom->mybox.lo[_x]=boundaries[0]; atom->mybox.hi[_x]=boundaries[1];
  atom->mybox.lo[_y]=boundaries[2]; atom->mybox.hi[_y]=boundaries[3];
  atom->mybox.lo[_y]=boundaries[4]; atom->mybox.hi[_y]=boundaries[5];
  
  MD_FLOAT domain[6] = {boundaries[0], boundaries[2], boundaries[4], boundaries[1], boundaries[3], boundaries[5]};
  MPI_Allgather(domain, 6, type, grid->map, 6, type, world);
  
  for(int dim=0; dim<3; dim++) {
    MPI_Comm_free(&subComm[dim]);
    free(load[dim]);
  }
  free(limits); 
}

//RCB algorithm
MD_FLOAT meanBisect(Atom* atom, MD_FLOAT* box, int dim)
{  
    int Natoms = 0;
    MD_FLOAT sum=0, mean=0; 
    
    for(int i=0; i<atom->Nlocal; i++){
        if (atom_x(i) >= box[_xlo] && atom_x(i) < box[_xhi] &&
            atom_y(i) >= box[_ylo] && atom_y(i) < box[_yhi] &&
            atom_z(i) >= box[_zlo] && atom_z(i) < box[_zhi] ) {
              sum += atom_pos(i);
              Natoms++; 
            }  
    }
    mean = sum/Natoms;
    return mean;
} 

int nextBisectionLevel(Grid* grid, Atom* atom, RCB_Method method, int dim ,int nboxes)
{ 
  int nprocs, index1, index2, index;
  int size = 6, finish = 0; //xlo, ylo, zlo, xhi, yhi, zhi 
  MD_FLOAT* map = grid->map;
  MD_FLOAT readmap[size*nboxes]; 
  MD_FLOAT bisection;
  MD_FLOAT root[size], branch1[size], branch2[size];
  MPI_Comm_size(MPI_COMM_WORLD, &nprocs);

  for(int i=0; i<size*nboxes; i++)
    readmap[i] = map[i];
  
  for(int ibox=0; ibox<nboxes; ibox++ )
  {
    for(int i =0; i<size; i++){
        root[i] = readmap[ibox*size+i];
        branch1[i] = readmap[ibox*size+i];
        branch2[i] = readmap[ibox*size+i];
    }      
    
    bisection = method(atom,root,dim);

    if(dim ==_x){
      branch1[_xhi] = bisection;
      branch2[_xlo] = bisection;
    } else if (dim ==_y){
      branch1[_yhi] = bisection;
      branch2[_ylo] = bisection;
    } else {
      branch1[_zhi] = bisection;
      branch2[_zlo] = bisection;
    }

    index1 = (2*ibox)*size; index2 = (2*ibox+1)*size;

    for(int i = 0; i<size; i++){
        map[index1+i]=branch1[i];
        map[index2+i]=branch2[i];
    }
    if(++nboxes>=nprocs){
      index = (2*(ibox+1))*size;
      finish = 1;
      break;
    }  
  }
  if(finish)
    for(int i=0; i<nboxes; i++)
      map[index] = readmap[i];

  return nboxes;
}

void rcbBalance(Grid* grid, Atom* atom, Parameter* param, RCB_Method method, int ndim)
{
  int me, nprocs=0, ilevel=0, nboxes=1;
  int hidim, mddim, lodim, index, prd[3];
  MPI_Comm_size(world, &nprocs);
  MPI_Comm_rank(world, &me);

  prd[_x] = atom->mybox.xprd = param->xprd; 
  prd[_y] = atom->mybox.yprd = param->yprd; 
  prd[_z] = atom->mybox.zprd = param->zprd;

  if(me == 0)
  {
    hidim = (prd[_x] >= prd[_y]) ? _x : _y; 
    if (prd[_z]> prd[hidim]) hidim = _z;
    mddim = (hidim+1)%3;
    lodim = (hidim+2)%3;
   
    int bisectDim[3] ={hidim, mddim, lodim};
    
    //Initial Map
    grid->map[_xlo]=0.; grid->map[_ylo]=0.; grid->map[_zlo]=0.; 
    grid->map[_xhi]=atom->mybox.xprd; 
    grid->map[_yhi]=atom->mybox.yprd; 
    grid->map[_zhi]=atom->mybox.zprd;
    
    ndim = MAX(ndim,2);
    while(nboxes<nprocs)
    { 
      index = (ilevel++)%ndim;
      nboxes = nextBisectionLevel(grid, atom, method, bisectDim[index], nboxes);
    }  
  }

  MPI_Bcast(&grid->map[0], 6*nprocs, type, 0, world);

  atom->mybox.lo[_x] = grid->map[6*me+_xlo];
  atom->mybox.lo[_y] = grid->map[6*me+_ylo];
  atom->mybox.lo[_z] = grid->map[6*me+_zlo];
  atom->mybox.hi[_x] = grid->map[6*me+_xhi];
  atom->mybox.hi[_y] = grid->map[6*me+_yhi];
  atom->mybox.hi[_z] = grid->map[6*me+_zhi];
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
  MPI_Cart_create(MPI_COMM_WORLD,numdim,griddim,periods,reorder,&cartesian); 
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
  grid->Timer = 0;
  grid->map_size = 6 * nprocs;             
  grid->map  = (MD_FLOAT*) allocate(ALIGNMENT, grid->map_size * sizeof(MD_FLOAT));  
 
}

void setupGrid(Grid* grid, Atom* atom, Parameter* param)
{
  int me; 
  MD_FLOAT xlo, ylo, zlo, xhi, yhi, zhi; 
  MPI_Comm_rank(MPI_COMM_WORLD, &me);
  grid->balance_every =10*param->reneigh_every;

  //Set the origin at (0,0,0)
  for(int i=0; i<atom->Nlocal; i++){
    atom_x(i) = atom_x(i) - param->xlo;
    atom_y(i) = atom_y(i) - param->ylo;
    atom_z(i) = atom_z(i) - param->zlo;
  }

  if(param->balance == 1) {
    int dims = 3; //TODO: Adjust to do in 3d and 2d
    rcbBalance(grid, atom, param, meanBisect, dims);
  } else { 
    cartisian3d(grid, param, &atom->mybox);
  }

  if(param->input_file != NULL){
    xlo = atom->mybox.lo[_x]; xhi = atom->mybox.hi[_x];  
    ylo = atom->mybox.lo[_y]; yhi = atom->mybox.hi[_y];
    zlo = atom->mybox.lo[_z]; zhi = atom->mybox.hi[_z];  

    int i = 0; 
    int nlocal = atom->Nlocal; 
 
    while(i < nlocal) {
      if(atom_x(i) >= xlo && atom_x(i) < xhi &&
         atom_y(i) >= ylo && atom_y(i) < yhi &&
         atom_z(i) >= zlo && atom_z(i) < zhi ) 
        { i++; } 
         else 
        {
          copy(atom, i, nlocal-1);
          nlocal--;  
        }
    }
    atom->Nlocal = nlocal; 
  } 
  MPI_Allreduce(&atom->Nlocal, &atom->Natoms, 1, MPI_INT, MPI_SUM, world);
  if(param->input_file != NULL) printf("Processor:%i, Local atoms:%i, Total atoms:%i\n",me, atom->Nlocal,atom->Natoms);
  MPI_Barrier(world);
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



