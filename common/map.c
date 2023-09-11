#include <map.h>
#include <mpi.h>

static enum{_x=0, _y, _z}; 


void RCB(Grid* grid, Atom* atom, int *prd)
{}

void cartisian3d(Grid* grid, Atom* atom, int *prd)
{
  int me, nproc;
  MPI_Comm_size(MPI_COMM_WORLD, &nproc);
  MPI_Comm_rank(MPI_COMM_WORLD, &me);

  int numdim=3;
  int reorder=0;
  int periods[3]={1,1,1}; 
  int mycoord[3]={0,0,0};
  int griddim[3];
  MPI_Comm cartesian;
  Box* box = &atom->mybox;

  box->xprd = prd[_x];
  box->yprd = prd[_y];
  box->zprd = prd[_z];

 //Creates a cartesian 3d grid 
  MPI_Dims_create(me, numdim, griddim); 
  MPI_Cart_create(MPI_COMM_WORLD,numdim,griddim,periods,reorder,&cartesian); 
 
  //Coordinates position in the grid
  MPI_Cart_coords(cartesian,me,3,mycoord); 

  //boundaries of my local box, with origin in (0,0,0). 
  box->len[_x] = prd[_x] / griddim[_x];
  box->len[_y] = prd[_y] / griddim[_y];
  box->len[_z] = prd[_z] / griddim[_z];
  
  box->lo[_x] = mycoord[_x] * box->len[_x];
  box->hi[_x] = (mycoord[_x] + 1) * box->len[_x];
  box->lo[_y] = mycoord[_y] * box->len[_y];
  box->hi[_y] = (mycoord[_y] + 1) * box->len[_y];
  box->lo[_z] = mycoord[_z] * box->len[_z];
  box->hi[_z] = (mycoord[_z] + 1) * box->len[_z];
  
  MD_FLOAT domain[6] = {box->lo[_x], box->lo[_y], box->lo[_z], box->hi[_x], box->hi[_y], box->hi[_z]};
  MPI_Allgather(grid->map, 6, MPI_FLOAT, domain, 6, MPI_FLOAT, MPI_COMM_WORLD);

}

void initGrid(Grid* grid)
{
  int me, nproc;
  MPI_Comm_size(MPI_COMM_WORLD, &nproc);
  MPI_Comm_rank(MPI_COMM_WORLD, &me);
  grid->map_size = 6 * nproc; 
  grid->map  = (MD_FLOAT*) allocate(ALIGNMENT, grid->map_size * sizeof(MD_FLOAT));  
}

void setupGrid(Grid* grid, Atom* atom, int* prd, int opt)
{
  if(opt == 0) {
    cartisian3d(grid, atom, *prd);
  } else{
    RCB(grid, atom, *prd);
  } 
}
