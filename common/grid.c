#include <stdio.h>
#include <grid.h>
#include <mpi.h>
#include <parameter.h>
#include <allocate.h>
#include <util.h>
#include <math.h>
static MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE;
static enum {_xlo=0, _ylo, _zlo, _xhi, _yhi, _zhi};

MD_FLOAT meanBisect(Atom* atom, MD_FLOAT* box, int dim)
{  
    int Natoms = 0;
    MD_FLOAT sum, mean; 
    
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
  int nprocs, ndomains, index1, index2, index;
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

void RCB(Grid* grid, Atom* atom, Parameter* param, RCB_Method method, int ndim)
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
    
    if(ndim!=2 && ndim!=3) ndim=2; 
    
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
 
  //Coordinates position in the grid
  MPI_Cart_coords(cartesian,me,3,mycoord); 
 
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

}

void initGrid(Grid* grid)
{ //start with regular grid
  int me, nprocs;
  MPI_Comm_size(world, &nprocs);
  MPI_Comm_rank(world, &me);
  grid->map_size = 6 * nprocs;             
  grid->map  = (MD_FLOAT*) allocate(ALIGNMENT, grid->map_size * sizeof(MD_FLOAT));  
}

void setupGrid(Grid* grid, Atom* atom, Parameter* param)
{
  int me; 
  MD_FLOAT xlo, ylo, zlo, xhi, yhi, zhi; 
  MPI_Comm_rank(MPI_COMM_WORLD, &me);
  
  //Set the origin at (0,0,0)
  for(int i=0; i<atom->Nlocal; i++){
    atom_x(i) = atom_x(i) - param->xlo;
    atom_y(i) = atom_y(i) - param->ylo;
    atom_z(i) = atom_z(i) - param->zlo;
  }

  if(param->rcb && param->input_file != NULL) {
    RCB(grid, atom, param, meanBisect, param->rcb_ndim);
  } else{
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
  MPI_Allreduce(&(atom->Nlocal), &(atom->Natoms), 1, MPI_INT, MPI_SUM, world);
  printf("Processor:%i, Local atoms:%i, Total atoms:%i\n",me, atom->Nlocal,atom->Natoms);
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
}


