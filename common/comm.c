#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//-------------------------------------------------------------
#include <comm.h>
#include <allocate.h>
#include <atom.h>
#include <mpi.h>
#include <mask.h>


#define BUFFACTOR 1.5
#define BUFMIN 1000
#define BUFEXTRA 100
#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define MAX(a,b) ((a) > (b) ? (a) : (b))

enum orientation {west=0, east, south, north, down, up};
enum  axis {_x=0, _y=1, _z=2};
static inline int index_pos(int i, int dim);
static inline MD_FLOAT* ptrAtom(Atom* atom,int dim);
static inline void initBuffers(Comm* comm);
static inline void freeBuffers(Comm* comm);

void initComm(int argc, char** argv, Comm* comm)
{
  //MPI Initialize
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &(comm->numproc));
  MPI_Comm_rank(MPI_COMM_WORLD, &(comm->myproc));
}
 
void endComm(Comm* comm)
{
   freeBuffers(comm);
   MPI_Finalize();
}

void setupComm(Comm* comm, Parameter* param)
{   
  int coordSender,iswap, displ; 
  MD_FLOAT hi,lo; 
  //Requiered variables to init mpi-cartesian
  MPI_Comm cartesian;
  int myproc=comm->myproc;
  int numproc=comm->numproc;
  int numdim=3;
  int reorder=0;
  int periods[3]={1,1,1}; 
  int mycoord[3]={0,0,0};
  MD_FLOAT prd[3];
  MD_FLOAT cutneigh = param->cutneigh; 

  comm->mybox.xprd = param->xprd;
  comm->mybox.yprd = param->yprd;
  comm->mybox.zprd = param->zprd;

  prd[_x] = comm->mybox.xprd;
  prd[_y] = comm->mybox.yprd;
  prd[_z] = comm->mybox.zprd;

 //Creates a cartesian 3d grid 
  MPI_Dims_create(numproc, numdim, comm->griddims); 
  MPI_Cart_create(MPI_COMM_WORLD,numdim,comm->griddims,periods,reorder,&cartesian); 
 
  //Coordinates position in the grid
  MPI_Cart_coords(cartesian,myproc,3,mycoord); 

  //boundaries of my local box
  comm->mybox.len[_x] = prd[_x] / comm->griddims[_x];
  comm->mybox.len[_y] = prd[_y] / comm->griddims[_y];
  comm->mybox.len[_z] = prd[_z] / comm->griddims[_z];
  
  comm->mybox.xlo = mycoord[_x] * comm->mybox.len[_x];
  comm->mybox.xhi = (mycoord[_x] + 1) * comm->mybox.len[_x];
  comm->mybox.ylo = mycoord[_y] * comm->mybox.len[_y];
  comm->mybox.yhi = (mycoord[_y] + 1) * comm->mybox.len[_y];
  comm->mybox.zlo = mycoord[_z] * comm->mybox.len[_z];
  comm->mybox.zhi = (mycoord[_z] + 1) * comm->mybox.len[_z];
  
  //Finding closest neighbours 
  MPI_Cart_shift(cartesian, _x, 1, &comm->procneigh[west], &comm->procneigh[east]);
  MPI_Cart_shift(cartesian, _y, 1, &comm->procneigh[south], &comm->procneigh[north]);
  MPI_Cart_shift(cartesian, _z, 1, &comm->procneigh[down], &comm->procneigh[up]);  

   //# of boxes to communicate in a single direction i.e. north, south...
  comm->numneigh[_x] = (int)(cutneigh / comm->mybox.len[_x] + 1);
  comm->numneigh[_y] = (int)(cutneigh / comm->mybox.len[_y] + 1);
  comm->numneigh[_z] = (int)(cutneigh / comm->mybox.len[_z] + 1); 
  
  // max # of swaps
  int maxswap = 2* (comm->numneigh[_x] + comm->numneigh[_y] + comm->numneigh[_z]); 
  comm->numswap = maxswap;
  //Allocate comm buffers memory
  initBuffers(comm);

  //set up the dimension and displacement of the neighbours procs 
  iswap = 0; 
  for (int dim = 0; dim < 3; dim++)
  { 
    for(int displ = 1; displ <= comm->numneigh[dim]; displ++, iswap+=2){
      comm->swapdim[iswap]   = comm->swapdim[iswap+1] =  dim; 
      comm->swapdis[iswap]   = -displ;
      comm->swapdis[iswap+1] =  displ;  
    }
  }
   
  //finding neighbours in all directions, swapping direction between.
  //1. sending atoms from W<-E, S<-N, down<-up
  //2. sending atoms from W->E, S->N, down->up 
  //                    __ __ __ __ __ __ __ __ __ __ __
  // Sender Array ->   |W0 |E0 |W1 |. |. |S |N |. |. |D |U |
  //                    ^  ^    ^       ^  ^        ^  ^
  //                    |  |    |       |  |        |  |
  //                    __ __ __ __ __ __ __ __ __ __ __
  // Receiver Array -> |E0 |W0 |E1 |. |. |N |S |. |. |U |D |
  
  for (iswap =0; iswap<maxswap; iswap++)
  { 
    MPI_Cart_shift(cartesian, comm->swapdim[iswap], comm->swapdis[iswap], &comm->recvproc_exc[iswap], &comm->sendproc_exc[iswap]);
  }

  MPI_Comm_free(&cartesian);

  //setting the slab region and pbc flgas to add or substract the range domain when sending
  //commflag(idim,nswap)    =  0 -> not across a boundary
  //                        =  1 -> add box-length to position when sending
  //                        = -1 -> subtract box-length from pos when sending */

  for(iswap = 0; iswap < maxswap; iswap++) {

    int dim   = comm->swapdim [iswap];
    int displ = comm->swapdis[iswap];
    int sender, receiv; 

    comm->pbc_flagx[iswap] = 0;
    comm->pbc_flagy[iswap] = 0;
    comm->pbc_flagz[iswap] = 0;   

    // Info sent from W<-E, S<-N, down<-up
    if(displ < 0)
    {
      sender  = (dim == _x) ? west : (dim == _y) ? south : down;  
      receiv  = (dim == _x) ? east : (dim == _y) ? north : up;

      comm->sendproc[iswap] = comm->procneigh[sender];
      comm->recvproc[iswap] = comm->procneigh[receiv];
      
      coordSender = mycoord[dim] - displ -1;
      
      lo = coordSender * comm->mybox.len[dim];
      hi = (dim == _x) ? comm->mybox.xlo : (dim == _y) ? comm->mybox.ylo : comm->mybox.zlo; 
      hi+= cutneigh; 
      hi = MIN(hi, (coordSender + 1) * comm->mybox.len[dim]);

      //pbc flags       
      if (dim == _x) comm->pbc_flagx[iswap] = 1;
      if (dim == _y) comm->pbc_flagy[iswap] = 1;
      if (dim == _z) comm->pbc_flagz[iswap] = 1; 
    
    } else {

      // Info sent from W->E, S->N, down->up
      sender  = (dim == _x) ? east : (dim == _y) ? north : up;  
      receiv  = (dim == _x) ? west : (dim == _y) ? south : down;

      comm->sendproc[iswap] = comm->procneigh[sender];
      comm->recvproc[iswap] = comm->procneigh[receiv];

      coordSender = mycoord[dim] - displ +1;
    
      hi = (coordSender+1) * comm->mybox.len[dim];
      lo = (dim == _x) ? comm->mybox.xhi : (dim == _y) ? comm->mybox.yhi : comm->mybox.yhi; 
      lo-= cutneigh;     
      lo = MAX(lo, coordSender * comm->mybox.len[dim]);

      //pbcflags
      comm->pbc_flagx[iswap+1] = -1;
      comm->pbc_flagy[iswap+1] = -1;
      comm->pbc_flagz[iswap+1] = -1;
    }

    comm->slablo[iswap] = lo;
    comm->slabhi[iswap] = hi;
  } 
}

void forwardComm(Comm* comm, Atom* atom)
{
  int iswap;
  int pbc_flags[3];
  MD_FLOAT* buf;

  for(iswap = 0; iswap < comm->numswap; iswap++) {

    /* pack buffer */
    pbc_flags[0] = comm->pbc_flagx[iswap];
    pbc_flags[1] = comm->pbc_flagy[iswap];
    pbc_flags[2] = comm->pbc_flagz[iswap];

    packForward(atom, comm->mybox, comm->sendnum[iswap], comm->sendlist[iswap], comm->buf_send, pbc_flags);

    /* exchange with another proc
       if self, set recv buffer to send buffer */
    if(comm->sendproc[iswap] != comm->myproc) {

      MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE;
      MPI_Sendrecv(comm->buf_send, comm->forward_send_size[iswap], type, comm->sendproc[iswap], 0,
                   comm->buf_recv, comm->forward_recv_size[iswap], type, comm->recvproc[iswap], 0,
                   MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      
      buf = comm->buf_recv;
    } else buf = comm->buf_send;

    /* unpack buffer */
    unpackForward(atom, comm->recvnum[iswap], comm->firstrecv[iswap], buf);
  }
}

void reverseComm(Comm* comm, Atom* atom)
{
  int iswap;
  int numswap = comm->numswap;
  MD_FLOAT* buf;

  for(iswap = numswap - 1; iswap >= 0; iswap--) {

    /* pack buffer */
    packReverse(atom, comm->recvnum[iswap], comm->firstrecv[iswap], comm->buf_send);

    /* exchange with another proc
       if self, set recv buffer to send buffer */
    if(comm->sendproc[iswap] != comm->myproc) {

      MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE;
      MPI_Sendrecv(comm->buf_send, comm->reverse_send_size[iswap], type, comm->recvproc[iswap], 0,
                    comm->buf_recv, comm->reverse_recv_size[iswap], type, comm->sendproc[iswap], 0,
                    MPI_COMM_WORLD, MPI_STATUS_IGNORE);

      buf = comm->buf_recv;
    } else buf = comm->buf_send;

    /* unpack buffer */
    unpackReverse(atom, comm->sendnum[iswap], comm->sendlist[iswap], buf);
  }
}

void exchange(Comm* comm, Atom* atom)
{
  int i, m, dim, nsend, nrecv, Nlocal, id;
  MD_FLOAT lo, hi, pos;
  MD_FLOAT* x;

  /* enforce PBC */
  pbc(atom, comm->mybox);

  /* loop over dimensions */
  int iswap = 0;

  for(dim = 0; dim < 3; dim++) {

  /* only exchange if more than one proc in this dimension */
  if(comm->griddims[dim] == 1) {
    iswap += 2 * comm->numneigh[dim];
    continue;
    }

    /* fill buffer with atoms leaving my box
    *        when atom is deleted, fill it in with last atom */
    i = nsend = 0;
    lo = (dim == _x) ? comm->mybox.xlo : (dim == _y) ? comm->mybox.ylo : comm->mybox.zlo;
    hi = (dim == _x) ? comm->mybox.xhi : (dim == _y) ? comm->mybox.yhi : comm->mybox.zhi;
    Nlocal = atom -> Nlocal;
  
    //return the ptr to the atom's position for each dimension
    x = ptrAtom(atom, dim);

    while(i < Nlocal) {
      id =  index_pos(i,dim);
      if(x[id] < lo || x[id] >= hi) {
        if(nsend > comm->maxsend) growSend(comm, nsend);
        nsend += packExchange(atom, i, &comm->buf_send[nsend]);
        copy(atom, Nlocal - 1, i);
        Nlocal--;
      } else i++;
    }

    atom->Nlocal = Nlocal;

    /* send/recv atoms in both directions
    *        only if neighboring procs are different */
    for(int ineigh = 0; ineigh < 2 * comm->numneigh[dim]; ineigh ++) {
      if(comm->griddims[dim] > 1) {
        MPI_Sendrecv(&nsend, 1, MPI_INT, comm->sendproc_exc[iswap], 0,
                     &nrecv, 1, MPI_INT, comm->recvproc_exc[iswap], 0,
                     MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        if(nrecv > comm->maxrecv) growRecv(comm, nrecv);


        MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE;
        MPI_Sendrecv(comm->buf_send, nsend, type, comm->sendproc_exc[iswap], 0,
                     comm->buf_recv, nrecv, type, comm->recvproc_exc[iswap], 0,
                     MPI_COMM_WORLD, MPI_STATUS_IGNORE);

    /* check incoming atoms to see if they are in my box
    *        if they are, add to my list */

    m = 0;
    while(m < nrecv) {
      pos = comm->buf_recv[m + dim];

      if(pos >= lo && pos < hi)
        m+= unpackExchange(atom, Nlocal++, &comm->buf_recv[m]);
      else m += 7; 
    }

      atom-> Nlocal = Nlocal;
    }

    iswap += 1;
      
    }
  }
}

void listComm(Comm* comm, Atom* atom)
{
  int i, iswap, dim, ineigh, nsend, nrecv, nfirst, nlast, id, displ;
  MD_FLOAT lo, hi;
  MD_FLOAT* px;

  /* erase all ghost atoms */
  atom->Nghost = 0;
  
  for(iswap = 0; iswap < comm->numswap; iswap++)
  { 
    // find atoms within slab boundaries lo/hi using <= and >=
    // check atoms between nfirst and nlast
    // store sent atom indices in list for use in future timesteps

    dim = comm->swapdim[iswap]; 
    displ = comm->swapdis[iswap];
    lo = comm->slablo[iswap];
    hi = comm->slabhi[iswap];
  
    //return the ptr to the atom position
    px = ptrAtom(atom, dim);

    //   for first swaps in a dim, check owned and ghost
    //   for later swaps in a dim, only check newly arrived ghosts

    if(displ < 0 ) {
      // Every -1 displ is a new dimension 
      if(displ == -1) nlast = 0; 
      nfirst = nlast;
      nlast = atom->Nlocal + atom->Nghost;
    }

    nsend = 0;

    for(int i = nfirst; i < nlast; i++) {
      id = index_pos(i, dim);
      if(px[id] >= lo && px[id] <= hi) {
        if(nsend >= comm->maxsendlist[iswap]) growList(comm, iswap, nsend);
        comm->sendlist[iswap][nsend++] = i;
      }
    }
    
    //Determine the number of elements to receive and send
    if (comm->sendproc[iswap] != comm->myproc) {
      MPI_Sendrecv(&nsend,1,MPI_INT,comm->sendproc[iswap],0,
                   &nrecv,1,MPI_INT,comm->recvproc[iswap],0,MPI_COMM_WORLD,MPI_STATUS_IGNORE);
    } else {
      nrecv = nsend;
    }

    comm->sendnum[iswap] = nsend;
    comm->recvnum[iswap] = nrecv;
    //Atoms forward send = Atoms Reverse Received
    comm->forward_send_size[iswap] = nsend * comm->atomSizeForward;
    comm->reverse_recv_size[iswap] = nsend * comm->atomSizeReverse;
    //Atoms forward received = Atoms send reverse 
    comm->forward_recv_size[iswap] = nrecv * comm->atomSizeForward;
    comm->reverse_send_size[iswap] = nrecv * comm->atomSizeReverse;
    
    comm->firstrecv[iswap] = atom->Nlocal + atom->Nghost;
    atom->Nghost += nrecv;
    
  }
  
  /* assure buffers are large enough for forward and reverse comm */
  int max1, max2, max3, max4;
  max1 = max2 = max3 = max4 = 0;

  for(iswap = 0; iswap < comm->numswap; iswap++) {
    max1 = MAX(max1, comm->forward_send_size[iswap]);
    max4 = MAX(max4, comm->reverse_recv_size[iswap]);
    max2 = MAX(max2, comm->forward_recv_size[iswap]);
    max3 = MAX(max3, comm->reverse_send_size[iswap]);
    
  }
  int maxsender = MAX(max1, max3);
  int maxreceiv = MAX(max2, max4);
  
  if(maxsender > comm->maxsend) growSend(comm, max1);
  if(maxreceiv > comm->maxrecv) growRecv(comm, max2);

}


/* free/malloc the size of the recv buffer as needed with BUFFACTOR */
void growRecv(Comm* comm, int n)
{
  comm -> maxrecv = (int) (BUFFACTOR * n);
  free(comm -> buf_recv);
  comm -> buf_recv = (MD_FLOAT*) allocate(ALIGNMENT, comm->maxrecv * sizeof(MD_FLOAT));
}

/* realloc the size of the send buffer as needed with BUFFACTOR & BUFEXTRA */
void growSend(Comm* comm, int n)
{
  comm -> maxsend = (int) (BUFFACTOR * n);
  comm -> buf_send = (MD_FLOAT*) reallocate(comm->buf_send, ALIGNMENT, (comm->maxsend + BUFEXTRA) * sizeof(MD_FLOAT), sizeof(comm->buf_send));
}
/* realloc the size of any list to send */
void growList(Comm* comm, int iswap, int n)
{
  comm->maxsendlist[iswap] = (int) (BUFFACTOR * n);
  comm->sendlist[iswap] = (int*) reallocate(comm->sendlist[iswap],ALIGNMENT, comm->maxsendlist[iswap] * sizeof(int), sizeof(comm->sendlist[iswap]));
}
/*Initialize all communication buffers*/
static inline void  initBuffers(Comm* comm)
{  
  comm->maxsend = BUFMIN;
  comm->maxrecv = BUFMIN;
  int nswap = comm->numswap; 
  
  //Unique buffer to send and receive every swap
  comm->buf_send = (MD_FLOAT*) allocate(ALIGNMENT,(comm->maxsend + BUFMIN) * sizeof(MD_FLOAT));
  comm->buf_recv = (MD_FLOAT*) allocate(ALIGNMENT, comm->maxrecv * sizeof(MD_FLOAT));  
  
  //Next buffers store information for each swap
  comm->slablo = (MD_FLOAT*) allocate(ALIGNMENT, nswap * sizeof(MD_FLOAT)); 
  comm->slabhi = (MD_FLOAT*) allocate(ALIGNMENT, nswap * sizeof(MD_FLOAT));

  comm->pbc_flagx = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->pbc_flagy = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->pbc_flagz = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  
  comm->sendnum = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->recvnum = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  
  comm->forward_send_size = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->forward_recv_size = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->reverse_send_size = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->reverse_recv_size = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  
  comm->sendproc = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->recvproc = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->sendproc_exc = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->recvproc_exc = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->swapdis      = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->swapdim      = (int*) allocate(ALIGNMENT, nswap * sizeof(int)); 

  comm->firstrecv = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  comm->maxsendlist = (int*) allocate(ALIGNMENT, nswap * sizeof(int));
  
  for(int i = 0; i < nswap; i++) 
    comm->maxsendlist[i] = BUFMIN;
  
  comm->sendlist = (int**) allocate(ALIGNMENT, nswap * sizeof(int*));
  
  for(int i = 0; i < nswap; i++) 
    comm->sendlist[i] = (int*) allocate(ALIGNMENT, BUFMIN * sizeof(int));
}
/*free all communication buffers*/
static inline void freeBuffers(Comm* comm)
{
  free(comm->buf_send);
  free(comm->buf_recv); 
  free(comm->slablo);  
  free(comm->slabhi); 
  free(comm->pbc_flagx);
  free(comm->pbc_flagy);
  free(comm->pbc_flagz);
  free(comm->sendnum);
  free(comm->recvnum);
  free(comm->forward_send_size);
  free(comm->forward_recv_size);
  free(comm->reverse_send_size);
  free(comm->reverse_recv_size);
  free(comm->sendproc);
  free(comm->recvproc);
  free(comm->sendproc_exc);
  free(comm->recvproc_exc);
  free(comm->swapdis);     
  free(comm->swapdim);     
  free(comm->firstrecv); 
  free(comm->maxsendlist); 
  free(comm->maxsendlist);
  for(int i = 0; i < comm->numswap; i++) 
    free(comm->sendlist); 
  free(comm->sendlist); 
}
/*Return the right index vector depending of AoS or SoA*/
static inline int index_pos(int i, int dim)
{
#ifdef AOS
  return i * 3 + dim; 
#else
  return i;
#endif
}
/*Return the right ptr vector depending of AoS or SoA*/
static inline MD_FLOAT* ptrAtom(Atom* atom,int dim)
{
#ifdef AOS
  return atom -> x;
#else 
  return (dim == _x) ? atom -> x : (dim == _y) ? atom -> y : atom -> z;
#endif
}


