#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <comm2.h>   //TODO:cheange here
#include <allocate.h>
#include <mpi.h>
#include <mask.h>


#define NEIGHMIN  8       
#define BUFFACTOR 1.5
#define BUFMIN    1000
#define BUFEXTRA  100
#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define MAX(a,b) ((a) > (b) ? (a) : (b))

enum  axis {_x=0, _y=1, _z=2};

static inline void initBuffers(Comm* comm);
static inline void freeBuffers(Comm* comm);


/*Here mybox is extended in a single dimmension using  the cutneigh,  
then check if overlaping  along a given dimension, if it does, they 
are neighbours in that dimension. To check intesection, all three 
porjections must be not null*/

void setupNeigh(Comm *comm, MD_FLOAT *map, MD_FLOAT cutneigh, MD_FLOAT *prd)
{
  int me = comm->myproc; 
  int numproc = comm ->numproc;
  int PAD = 6;   //number of elements for processor in the map
  int ineigh = 0;
  int count =0;
  Tile mybox, other, tile;

  //My box
  mybox.lo[_x] = map[me*PAD+0];  mybox.hi[_x] = map[me*PAD+3];
  mybox.lo[_y] = map[me*PAD+1];  mybox.hi[_y] = map[me*PAD+4];
  mybox.lo[_z] = map[me*PAD+2];  mybox.hi[_z] = map[me*PAD+5];

  //MAP is stored as follows: xlo,ylo,zlo,xhi,yhi,zhi
  for(int iswap = 0; iswap <6; iswap++)
  {
    int dir = comm->swapdir[iswap]; 
    int dim = comm->swapdim[iswap]; 
    //Iterate along my procs to finde the neighbours
    for(int proc = 0; proc < numproc; proc++)
    {
      if(proc == me) continue;

      //other box  
      other.lo[_x] = map[proc*PAD+0];  other.hi[_x] = map[proc*PAD+3];
      other.lo[_y] = map[proc*PAD+1];  other.hi[_y] = map[proc*PAD+4];
      other.lo[_z] = map[proc*PAD+2];  other.hi[_z] = map[proc*PAD+5];
      
      int pbc = overlapTiles(dim,dir,&mybox,&other,&tile,prd[dim],cutneigh);
      if(pbc == -100) continue; 
          
      tileRequired(iswap, &mybox, &other, &tile, cutneigh);
 
      if(ineigh > comm->maxneigh) {
          comm -> maxneigh  = (int) 2*ineigh;  
          comm -> neigh     = (int*) reallocate(comm->neigh, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->neigh));
          comm -> pbc_x     = (int*) reallocate(comm->neigh, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->pbc_x));
          comm -> pbc_y     = (int*) reallocate(comm->neigh, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->pbc_y));
          comm -> pbc_z     = (int*) reallocate(comm->neigh, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->pbc_z));
          comm -> tiles     = (Tile*)reallocate(comm->tiles, ALIGNMENT, comm->maxneigh * sizeof(Tile), sizeof(comm->tiles));
        }

        comm->tiles[ineigh] = tile;  
        comm->neigh[ineigh] = proc;
        comm->pbc_x[ineigh] = (dim == _x) ? pbc : 0;
        comm->pbc_y[ineigh] = (dim == _y) ? pbc : 0; 
        comm->pbc_z[ineigh] = (dim == _z) ? pbc : 0; 
        ineigh++;
    }

  comm->from[iswap] = count;
  comm->until[iswap] = ineigh;
  comm->neighswap[iswap] = ineigh - count; 
  comm->numneigh = ineigh;  
  count = ineigh;
  }
}
  
int overlapTiles(int dim, int dir, const Tile* mybox, const Tile* other, Tile* cut, int prdlen, int cutneigh)
{
  int min[3], max[3];
  //projections
  min[_x] = MAX(mybox->lo[_x], other->lo[_x]); max[_x] = MIN(mybox->hi[_x], other->hi[_x]); 
  min[_y] = MAX(mybox->lo[_y], other->lo[_y]); max[_y] = MIN(mybox->hi[_y], other->hi[_y]);
  min[_z] = MAX(mybox->lo[_z], other->lo[_z]); max[_z] = MIN(mybox->hi[_z], other->hi[_z]);
  
  //Intersection no periodic case
  if (dir ==  0)  min[dim] = MAX(mybox->lo[dim] - cutneigh, other->lo[dim]);
  if (dir ==  1)  max[dim] = MIN(mybox->hi[dim] + cutneigh, other->hi[dim]);
  int noprd = (min[_x]<max[_x]) && (min[_y]<max[_y]) && (min[_z]<max[_z]);

  //Intersection periodic case
  if (dir ==  0)  min[dim] = MAX(mybox->lo[dim] - cutneigh + prdlen, other->lo[dim]);
  if (dir ==  1)  max[dim] = MIN(mybox->hi[dim] + cutneigh - prdlen, other->hi[dim]);
  int prd = (min[_x]<max[_x]) && (min[_y]<max[_y]) && (min[_z]<max[_z]);
  //store the cuts
  cut->lo[_x] = min[_x]; cut->hi[_x] = max[_x]; 
  cut->lo[_y] = min[_y]; cut->hi[_y] = max[_y];
  cut->lo[_z] = min[_z]; cut->hi[_z] = max[_z];

  if(noprd) return 0;
  else if(prd && dir ==  0) return 1;
  else if(prd && dir ==  1) return -1;
  else return -100; 
}
  
 void tileRequired(int iswap, const Tile* me, const Tile* other, Tile* tile, int cutneigh)
 {
  switch (iswap) {
  case 0:
      tile->lo[_x] = me->lo[_x]; 
      tile->hi[_x] = me->lo[_x]+cutneigh;
      break;
  case 1: 
      tile->lo[_x] = me->hi[_x]; 
      tile->hi[_x] = me->hi[_x]-cutneigh;
      break;
  case 2:
      tile->lo[_y] = me->lo[_y]; 
      tile->hi[_y] = me->lo[_y]+cutneigh;
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      break;
  case 3:
      tile->lo[_y] = me->hi[_y]; 
      tile->hi[_y] = me->hi[_y]-cutneigh;
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      break;
  case 4: 
      tile->lo[_z] = me->lo[_z]; 
      tile->hi[_z] = me->lo[_z]+cutneigh;
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      if(me->lo[_y] < other->lo[_y]) tile->lo[_y] -= cutneigh;
      if(me->hi[_y] > other->hi[_y]) tile->lo[_y] += cutneigh;
      break;
  case 5: 
      tile->lo[_z] = me->hi[_z]; 
      tile->hi[_z] = me->hi[_z]-cutneigh;
      if(me->lo[_x] < other->lo[_x]) tile->lo[_x] -= cutneigh;
      if(me->hi[_x] > other->hi[_x]) tile->lo[_x] += cutneigh;
      if(me->lo[_y] < other->lo[_y]) tile->lo[_y] -= cutneigh;
      if(me->hi[_y] > other->hi[_y]) tile->lo[_y] += cutneigh;
      break;
  }
}

void initComm(int argc, char** argv, Comm* comm)
{
  //MPI Initialize
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &(comm->numproc));
  MPI_Comm_rank(MPI_COMM_WORLD, &(comm->myproc));
}
 
void endComm(Comm* comm)
{
  comm->maxneigh = 0;
  comm->maxsend = 0; 
  comm->maxrecv = 0;
   freeBuffers(comm);
   MPI_Finalize();
}

void setupComm(Comm* comm, Parameter* param, Atom* atom, MD_FLOAT* map){
 
  comm->swap[_x][0] = 0; comm->swap[_x][1] =1;
  comm->swap[_y][0] = 2; comm->swap[_y][1] =3;
  comm->swap[_z][0] = 4; comm->swap[_z][1] =5;

  comm->swapdim[0] = comm->swapdim[1] = _x;
  comm->swapdim[2] = comm->swapdim[3] = _y;
  comm->swapdim[4] = comm->swapdim[5] = _z;

  comm->swapdir[0] = 0; comm->swapdir[2] = comm->swapdir[4] = 0;
  comm->swapdir[1] = 0; comm->swapdir[3] = comm->swapdir[5] = 1;

  comm->numneigh = 0;

  for(int i = 0;  i<6; i++){
    comm->from[i] = 0;
    comm->until[i] = 0;
    comm->neighswap[i] = 0;  
  }

  comm->size_for = 3;
  comm->size_rev = 3;
  comm->size_exc = 7;

  comm->maxneigh = NEIGHMIN;
  comm->maxsend = BUFMIN; 
  comm->maxrecv = BUFMIN;

  comm->neigh  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_x  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_y  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_z  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->tiles  = (Tile*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(Tile));

  setupNeigh(comm, map, param->cutneigh, (int[3]){param->xprd, param->yprd, param->zprd});   
  initBuffers(comm);  
}

void forwardComm(Comm* comm, Atom* atom, int iswap)
{
  //atom->nghost must be restart before each new forward

  MD_FLOAT xlo, xhi, ylo, yhi, zlo, zhi, prdx, prdy, prdz; 
  int nr=0, nsend, pbc[3];
  int all_recv=0, all_send=0, border_size=0; //border_size = atoms*4
  int dim = comm->swapdim[iswap];
  int dir = comm->swapdir[iswap];
  int otherswap = comm->swap[dim][(dir+1)%2];
  int prd[3] = {atom->mybox.xprd, atom->mybox.yprd, atom->mybox.zprd};

  int ntorecv = comm->neighswap[otherswap]; 
  int ntosend = comm->neighswap[iswap];
  int size_for = comm->size_for; 

  MPI_Request requests[ntorecv];  
  MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE; 
  
  for(int ineigh = comm->from[iswap]; ineigh< comm->until[iswap]; ineigh++)
      {          
        Tile* tile = &comm->tiles[ineigh]; //Becarefull here, check for it
        
        xlo = tile->lo[_x]; ylo = tile->lo[_y]; zlo = tile->lo[_x]; 
        xhi = tile->hi[_x]; yhi = tile->hi[_y]; zhi = tile->lo[_z];   
      
        pbc[_x]=comm->pbc_x[ineigh]; pbc[_y]=comm->pbc_y[ineigh];  pbc[_z]=comm->pbc_z[ineigh];
        
        prdx = pbc[_x]*prd[_x];   
        prdy = pbc[_y]*prd[_y];   
        prdz = pbc[_z]*prd[_z];

        nsend = 0; 
        //CHECK:check doing more work than should 
        for(int i = 0; i < atom->Nlocal+atom->Nghost; i++) 
        {
          if (atom_x(i)+prdx >= xlo && atom_x(i)+prdx < xhi &&
              atom_y(i)+prdy >= ylo && atom_z(i)+prdy < yhi &&
              atom_z(i)+prdz >= zlo && atom_z(i)+prdz < zhi ) {
                if(nsend >= comm->maxsendlist[ineigh]) growList(comm,ineigh,nsend);
                if(border_size >= comm->maxsend) growSend(comm,border_size);
                comm->sendlist[ineigh][nsend++] = i;
                border_size += packBorder(i, &comm->buf_send[border_size], pbc);  //TODO:No parallel with omp because boder dependency
          }      
        }
        comm->atom_send[ineigh]     = nsend;                //#atoms send per neigh   
        comm->size_send[ineigh]     = nsend*size_for;       //size_send = #atoms*size_for
        comm->off_atom_send[ineigh] = all_send;              //offset atom respect to neighbours 
        comm->off_buff_send[ineigh] = all_send*size_for;    //offset buffer respect to neighbours    
        all_send += nsend;                                  //all atoms send
      }   
  
  //Receives how many elements to be received.
  for(int ineigh = comm->from[otherswap],n=0; ineigh< comm->until[otherswap]; ineigh++)
    MPI_Irecv(&comm->atom_recv[ineigh],1,MPI_INT,comm->neigh[ineigh],0, MPI_COMM_WORLD,&requests[n++]);
  
  //Communicate how many elements to be sent.
  for(int ineigh = comm->from[iswap]; ineigh< comm->until[iswap]; ineigh++)
    MPI_Send(&comm->atom_send[ineigh],1,MPI_INT,comm->neigh[ineigh],0,MPI_COMM_WORLD);    
  MPI_Waitall(ntorecv,requests,MPI_STATUS_IGNORE);
  
  //Define offset to store in the recv_buff
  for(int ineigh = comm->from[otherswap]; ineigh<comm->until[otherswap]; ineigh++){ 
    comm->size_recv[ineigh] = comm->atom_recv[ineigh] * size_for;
    comm->off_atom_recv[ineigh] = all_recv;
    comm->off_buff_recv[ineigh] = all_recv * size_for; //CHECK: comm->off_buff_recv it could be local
    all_recv += comm->atom_recv[ineigh];
  }
  
  //Receives elements as long as the # elements is non zero
  for (int ineigh = comm->from[otherswap]; ineigh< comm->until[otherswap]; ineigh++){
    if (comm->atom_recv[ineigh])
      MPI_Irecv(&comm->buf_recv[comm->off_buff_recv[ineigh]], comm->size_recv[ineigh], 
                          type, comm->neigh[ineigh],0,MPI_COMM_WORLD,&requests[nr++]);
  }
  
  //Sent elements as long as the # elements is no zero
  for (int ineigh = comm->from[iswap]; ineigh< comm->until[iswap]; ineigh++){
    if (comm->atom_send[ineigh]) 
      MPI_Send(&comm->buf_send[comm->off_buff_send[ineigh]],comm->size_send[ineigh],
                                          type,comm->neigh[ineigh],0,MPI_COMM_WORLD); 
  }
  MPI_Waitall(nr,requests,MPI_STATUS_IGNORE);

/*   TODO: exchange if self, set recv buffer to send buffer 
    if(sendproc[iswap] != me) {
      buf = buf_recv;
    } else buf = buf_send;
*/
  
    
    for(int i = 0; i < all_recv; i++)
      unpackBorder(atom, atom->Nlocal+atom->Nghost, &comm->buf_recv[i*size_for]);

    comm->firstrecv[iswap] = atom->Nlocal + atom->Nghost; 
    atom->Nghost += all_recv;

    //Ensure send buffer and recv buffer has enough space for all atoms.
    int max = size_for * MAX(all_send, all_recv);
    if(max >= comm->maxsend) growSend(comm,max);
    if(max >= comm->maxrecv) growRecv(comm,max);

}
  
void reverseComm(Comm* comm, Atom* atom, int iswap)
{ 
    int nr=0, offset=0; 
    int dim = comm->swapdim[iswap];
    int dir = comm->swapdir[iswap];
    int otherswap = comm->swap[dim][(dir+1)%2];
    int size_rev = comm->size_rev; 
    //MD_FLOAT* buf;
    int ntorecv = comm->neighswap[iswap];
    MPI_Request requests[ntorecv];
    MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE; 

    for(int ineigh = comm->from[otherswap]; ineigh < comm->until[otherswap]; ineigh++){
      offset = comm->off_atom_recv[ineigh];
      packReverse(atom, comm->atom_recv[ineigh], comm->firstrecv[iswap]+ offset, &comm->buf_send[offset*size_rev]);
    }

    //Receives elements as long as the # elements is non zero
    for (int ineigh = comm->from[iswap]; ineigh< comm->until[iswap]; ineigh++){
      if (comm->atom_send[ineigh]){ 
        offset = comm->off_atom_send[ineigh]*size_rev; 
        MPI_Irecv(&comm->buf_recv[offset], comm->atom_send[ineigh]*size_rev, 
                              type, comm->neigh[ineigh],0,MPI_COMM_WORLD,&requests[nr++]);
      }
    }
    
    //Sent elements as long as the # elements is no zero
    for (int ineigh = comm->from[otherswap]; ineigh< comm->until[otherswap]; ineigh++){
      if (comm->atom_recv[ineigh]){
        offset = comm->off_atom_recv[ineigh]*size_rev; 
        MPI_Send(&comm->buf_send[offset],comm->atom_recv[ineigh]*size_rev,
                                              type,comm->neigh[ineigh],0,MPI_COMM_WORLD);        
      } 
 
    } 
    MPI_Waitall(nr,requests,MPI_STATUS_IGNORE);

      /* unpack buffer */ 
    for (int ineigh = comm->from[iswap]; ineigh< comm->until[iswap]; ineigh++){
      offset =  comm->off_atom_send[ineigh]*size_rev;
      unpackReverse(atom, comm->atom_send[ineigh], comm->sendlist[ineigh], &comm->buf_recv[offset]);
    }

    /* TODO: exchange with another proc
       if self, set recv buffer to send buffer 
    if(comm->sendproc[iswap] != comm->myproc) {
      buf = comm->buf_recv;
    } else buf = comm->buf_send;*/
}

void exchangeComm(Comm* comm, Atom* atom){

  int i, m, n, nsend, nrecv, nexch, nlocal, value, swap0, swap1; 
  MD_FLOAT value, lo, hi;
  MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE; 
  /*Number of paramters per atom, x,y,z,vx,vy,vz,type
  If more requiered, increase this number*/
  int size_exch = comm->size_exc;

  /* enforce PBC */
  pbc(atom);

  for(int dim = 0; dim < 3; dim++) {

    swap0 = comm->swap[dim][0]; 
    swap1 = comm->swap[dim][1];
    nexch = comm->neighswap[swap0]+comm->neighswap[swap1]; 
    int off_buff_recv[nexch];
    int size_recv[nexch];
    MPI_Requests requests[nexch];
    
    /* TODO:only exchange if more than one proc in this dimension */

    i = nsend = nrecv = 0;
    lo = atom->mybox.lo[dim];
    hi = atom->mybox.hi[dim];
    nlocal = atom->Nlocal;
    
    /* fill buffer with atoms leaving my box
    *        when atom is deleted, fill it in with last atom */
    while(i < nlocal) {
      value = (dim==_x) ? atom_x(i) : (dim==_y) ? atom_y(i) : atom_z(i);
      if(value < lo || value >= hi) {
        if(nsend > comm->maxsend) growSend(comm, nsend);
        nsend += packExchange(atom, i, &comm->buf_send[nsend]);
        copy(atom, nlocal - 1, i);
        nlocal--;
      } else i++;
    }

    atom->Nlocal = nlocal;
    
    /* send/recv atoms in both directions
    only if neighboring procs are different */

    for(int ineigh = comm->from[swap0], n=0; ineigh < comm->until[swap1]; ineigh++) 
        MPI_Irecv(&size_recv[ineigh],1,MPI_INT,comm->neigh[ineigh],0,MPI_COMM_WORLD,&requests[n++]);

    for (int ineigh = comm->from[swap0]; ineigh < comm->until[swap1]; ineigh++)
      MPI_Send(&nsend,1,MPI_INT,comm->neigh[ineigh],0,MPI_COMM_WORLD);
    MPI_Waitall(nexch,requests,MPI_STATUS_IGNORE);

    //Define offset to store in the recv_buff
    for(int ineigh = comm->from[swap0]; ineigh<comm->until[swap1]; ineigh++){ 
      off_buff_recv[ineigh] = nrecv; 
      nrecv += size_recv[ineigh];
    }

    if(nrecv >= comm->maxrecv) growRecv(comm,nrecv); 

    //Receives elements as long as the # elements is non zero
    for (int ineigh = comm->from[swap0], n=0; ineigh< comm->until[swap1]; ineigh++)
        MPI_Irecv(&comm->buf_recv[off_buff_recv[ineigh]], size_recv[ineigh], 
                          type, comm->neigh[ineigh],0,MPI_COMM_WORLD,&requests[n++]);
  
    //Sent elements as long as the # elements is no zero
    for (int ineigh = comm->from[swap0]; ineigh< comm->until[swap1]; ineigh++)
        MPI_Send(comm->buf_send,nsend,type,comm->neigh[ineigh],0,MPI_COMM_WORLD); 
    MPI_Waitall(nexch,requests,MPI_STATUS_IGNORE);  

    /* check incoming atoms to see if they are in my box
     *        if they are, add to my list */

    n = atom->Nlocal;
    m = 0;
  
    while(m < nrecv) {
      value = comm->buf_recv[m + dim];
      if(value >= lo && value < hi)
        m += unpackExchange(atom, n++, &comm->buf_recv[m]);
      else m += size_exch;
    }
    atom->Nlocal = n;
  }
}

inline void growRecv(Comm* comm, int n)
{
  comm -> maxrecv = (int) (BUFFACTOR * n);
  free(comm -> buf_recv);
  comm -> buf_recv = (MD_FLOAT*) allocate(ALIGNMENT, comm->maxrecv * sizeof(MD_FLOAT));
}

inline void growSend(Comm* comm, int n)
{
  comm -> maxsend = (int) (BUFFACTOR * n);
  comm -> buf_send = (MD_FLOAT*) reallocate(comm->buf_send, ALIGNMENT, (comm->maxsend + BUFEXTRA) * sizeof(MD_FLOAT), sizeof(comm->buf_send));
}

inline void growList(Comm* comm, int ineigh, int n)
{
  comm->maxsendlist[ineigh] = (int) (BUFFACTOR * n);
  comm->sendlist[ineigh] = (int*) reallocate(comm->sendlist[ineigh],ALIGNMENT, comm->maxsendlist[ineigh] * sizeof(int), sizeof(comm->sendlist[ineigh]));
}

static inline void  initBuffers(Comm* comm)
{  
  //Buffers depending on the # of my neighs 
  int numneigh = comm->numneigh;
    
  comm->atom_send   = (int*) allocate(ALIGNMENT,  numneigh  * sizeof(int));
  comm->atom_recv   = (int*) allocate(ALIGNMENT,  numneigh * sizeof(int));
  comm->size_send   = (int*) allocate(ALIGNMENT,  numneigh * sizeof(int));
  comm->size_recv   = (int*) allocate(ALIGNMENT,  numneigh * sizeof(int));
  comm->off_atom_send = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
  comm->off_atom_recv = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
  comm->off_buff_send = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
  comm->off_buff_recv = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
  comm->maxsendlist   = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));

  for(int i = 0; i < numneigh; i++) 
    comm->maxsendlist[i] = BUFMIN;
  
  comm->sendlist = (int**) allocate(ALIGNMENT, numneigh * sizeof(int*));
  for(int i = 0; i < numneigh; i++) 
  comm->sendlist[i] = (int*) allocate(ALIGNMENT, BUFMIN * sizeof(int));

  comm->buf_send = (MD_FLOAT*) allocate(ALIGNMENT,(comm->maxsend + BUFMIN) * sizeof(MD_FLOAT));
  comm->buf_recv = (MD_FLOAT*) allocate(ALIGNMENT, comm->maxrecv * sizeof(MD_FLOAT));  
}

static inline void freeBuffers(Comm* comm)
{
  free(comm->neigh);  
  free(comm->pbc_x); 
  free(comm->pbc_y);  
  free(comm->pbc_z);  
  free(comm->tiles);  
  free(comm->atom_send);     
  free(comm->atom_recv); 
  free(comm->size_send);   
  free(comm->size_recv);   
  free(comm->off_atom_send); 
  free(comm->off_atom_recv);
  free(comm->off_buff_send); 
  free(comm->off_buff_recv); 
  free(comm->maxsendlist); 
 
  for(int i = 0; i < comm->numneigh; i++) 
    free(comm->sendlist[i]); 
  free(comm->sendlist);

  free(comm->buf_send); 
  free(comm->buf_recv);   
}


