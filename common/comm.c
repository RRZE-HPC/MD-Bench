#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <comm.h>   
#include <allocate.h>
#include <mpi.h>
#include <util.h>

#define NEIGHMIN  8       
#define BUFFACTOR 1.5
#define BUFMIN    1000
#define BUFEXTRA  100
#define world MPI_COMM_WORLD

MPI_Datatype type = (sizeof(MD_FLOAT) == 4) ? MPI_FLOAT : MPI_DOUBLE; 
static inline void initBuffers(Comm*);
static inline void freeBuffers(Comm*);

int isInSwap(Comm* comm, int swap, int proc)
{
  for(int i=comm->sendfrom[swap]; i<comm->sendtill[swap]; i++)
    if (proc == comm->nsend[i]) return 1; 
  return 0;
}

void defineReverseandExchangeLists(Comm* comm){
  int index = 0; 
  int dim = 0;
  int me = comm->myproc;
//Set the inverse neighbour list
  for(int iswap = 0; iswap<6; iswap++){
    int dim = comm->swapdim[iswap]; 
    int dir = comm->swapdir[iswap];
    int invswap = comm->swap[dim][(dir+1)%2];   
    
    for(int i = comm->sendfrom[invswap]; i< comm->sendtill[invswap]; i++)
      comm->nrecv[index++] = comm->nsend[i];  
    
    comm->recvfrom[iswap] = (iswap == 0) ? 0: comm->recvtill[iswap-1];
    comm->recvtill[iswap] = index;
  }

  //Set the exchange neighbour list
  for(index = 0, dim = 0; dim<3; dim++)
  {
    int iswap0 = comm->swap[dim][0];  int iswap1 = comm->swap[dim][1];
    
    for (int ineigh = comm->sendfrom[iswap0]; ineigh<comm->sendtill[iswap0]; ineigh++)
      if(comm->nsend[ineigh]!= me) 
        comm->nexch[index++] = comm->nsend[ineigh];

    for(int ineigh = comm->sendfrom[iswap1]; ineigh<comm->sendtill[iswap1]; ineigh++)
      if(!isInSwap(comm,iswap0,comm->nsend[ineigh]) && comm->nsend[ineigh]!= me) 
        comm->nexch[index++] = comm->nsend[ineigh];

    comm->exchfrom[dim] = (dim == _x) ? 0: comm->exchtill[dim-1];
    comm->exchtill[dim] = index;
  }
  
  //set if myproc is unique in the swap 
  for(int iswap =0; iswap<6; iswap++){
    int sizeswap = comm->sendtill[iswap]-comm->sendfrom[iswap]; 
    int index = comm->sendfrom[iswap];
    int myneigh = comm->nsend[index];
    comm->othersend[iswap] = (sizeswap != 1 || comm->myproc != myneigh) ?  1 : 0;
  }
}

void neighComm(Comm *comm, MD_FLOAT *map, MD_FLOAT cutneigh, MD_FLOAT *prd)
{
  int me = comm->myproc; 
  int numproc = comm ->numproc;
  int PAD = 6;   //number of elements for processor in the map
  int ineigh = 0;
  Box mybox, other, cut;
  
  //My box
  mybox.id = me;
  mybox.lo[_x] = map[me*PAD+0];  mybox.hi[_x] = map[me*PAD+3];
  mybox.lo[_y] = map[me*PAD+1];  mybox.hi[_y] = map[me*PAD+4];
  mybox.lo[_z] = map[me*PAD+2];  mybox.hi[_z] = map[me*PAD+5];

  //MAP is stored as follows: xlo,ylo,zlo,xhi,yhi,zhi
  for(int iswap = 0; iswap <6; iswap++)
  {
    int dir = comm->swapdir[iswap]; 
    int dim = comm->swapdim[iswap]; 
 
    for(int proc = 0; proc < numproc; proc++)
    {
      //other box  
      other.id = proc;
      other.lo[_x] = map[proc*PAD+0];  other.hi[_x] = map[proc*PAD+3];
      other.lo[_y] = map[proc*PAD+1];  other.hi[_y] = map[proc*PAD+4];
      other.lo[_z] = map[proc*PAD+2];  other.hi[_z] = map[proc*PAD+5]; 
      int pbc = overlapBox(dim,dir,&mybox,&other,&cut,prd[dim],cutneigh);

      if(pbc == -100) continue;   

      expandBox(iswap, &mybox, &other, &cut, cutneigh);
       
      if(ineigh >= comm->maxneigh) {
          int oldByteSize = comm->maxneigh*sizeof(int);
          int oldBoxSize = comm->maxneigh*sizeof(Box); 
          comm -> maxneigh  = (int) 2*ineigh;  
          comm -> nsend     = (int*) reallocate(comm->nsend, ALIGNMENT,  comm->maxneigh * sizeof(int), oldByteSize);
          comm -> nrecv     = (int*) reallocate(comm->nrecv, ALIGNMENT,  comm->maxneigh * sizeof(int), oldByteSize);
          comm -> nexch     = (int*) reallocate(comm->nexch, ALIGNMENT,  comm->maxneigh * sizeof(int), oldByteSize);
          comm -> pbc_x     = (int*) reallocate(comm->pbc_x, ALIGNMENT,  comm->maxneigh * sizeof(int), oldByteSize);
          comm -> pbc_y     = (int*) reallocate(comm->pbc_y, ALIGNMENT,  comm->maxneigh * sizeof(int), oldByteSize);
          comm -> pbc_z     = (int*) reallocate(comm->pbc_z, ALIGNMENT,  comm->maxneigh * sizeof(int), oldByteSize);
          comm -> boxes     = (Box*) reallocate(comm->boxes, ALIGNMENT,  comm->maxneigh * sizeof(Box), oldBoxSize);
        }

      comm->boxes[ineigh] = cut;  
      comm->nsend[ineigh] = proc;
      comm->pbc_x[ineigh] = (dim == _x) ? pbc : 0;
      comm->pbc_y[ineigh] = (dim == _y) ? pbc : 0; 
      comm->pbc_z[ineigh] = (dim == _z) ? pbc : 0; 
      ineigh++; 
    }

  comm->sendfrom[iswap] = (iswap == 0) ? 0:comm->sendtill[iswap-1];
  comm->sendtill[iswap] = ineigh;
  comm->numneigh = ineigh; 
  }
  initBuffers(comm);
  defineReverseandExchangeLists(comm);
  
}
    
void initComm(int* argc, char*** argv, Comm* comm)
{
  //MPI Initialize
  MPI_Init(argc, argv);
  MPI_Comm_size(MPI_COMM_WORLD, &comm->numproc);
  MPI_Comm_rank(MPI_COMM_WORLD, &comm->myproc);
  comm->numneigh = 0;
  comm->nrecv=NULL;
  comm->nsend=NULL;
  comm->nexch=NULL;  
  comm->pbc_x=NULL; 
  comm->pbc_y=NULL;  
  comm->pbc_z=NULL;  
  comm->boxes=NULL;  
  comm->atom_send=NULL;     
  comm->atom_recv=NULL;   
  comm->off_atom_send=NULL; 
  comm->off_atom_recv=NULL;
  comm->maxsendlist=NULL; 
 
  for(int i = 0; i < comm->numneigh; i++) 
    comm->sendlist[i]=NULL; 
  comm->sendlist=NULL;

  comm->buf_send=NULL; 
  comm->buf_recv=NULL; 
}
 
void endComm(Comm* comm)
{
  comm->maxneigh = 0;
  comm->maxsend = 0; 
  comm->maxrecv = 0;
  freeBuffers(comm);
  MPI_Finalize();
}

void setupComm(Comm* comm, Parameter* param, MD_FLOAT* map){
 
  int i=0; 

  comm->swap[_x][0] = 0; comm->swap[_x][1] =1;
  comm->swap[_y][0] = 2; comm->swap[_y][1] =3;
  comm->swap[_z][0] = 4; comm->swap[_z][1] =5;

  comm->swapdim[0] = comm->swapdim[1] = _x;
  comm->swapdim[2] = comm->swapdim[3] = _y;
  comm->swapdim[4] = comm->swapdim[5] = _z;

  comm->swapdir[0] = comm->swapdir[2] = comm->swapdir[4] = 0;
  comm->swapdir[1] = comm->swapdir[3] = comm->swapdir[5] = 1;
  
  for(int i = 0;  i<6; i++){
    comm->sendfrom[i] = 0;
    comm->sendtill[i] = 0;
    comm->recvfrom[i] = 0;
    comm->recvtill[i] = 0;  
  }

  for(int dim = 0;  dim<3; dim++){
    comm->exchfrom[i] = 0;
    comm->exchtill[i] = 0; 
  }

  comm->forwardSize   = FORWARD_SIZE;      //send coordiantes x,y,z
  comm->reverseSize   = REVERSE_SIZE;      //return forces fx, fy, fz
  comm->ghostSize     = GHOST_SIZE;        //send x,y,z,type;
  comm->exchangeSize  = EXCHANGE_SIZE;     //send x,y,z,vx,vy,vz,type
 
  //Allocate memory for recv buffer and recv buffer
  comm->maxsend = BUFMIN; 
  comm->maxrecv = BUFMIN;
  comm->buf_send = (MD_FLOAT*) allocate(ALIGNMENT,(comm->maxsend + BUFMIN) * sizeof(MD_FLOAT));
  comm->buf_recv = (MD_FLOAT*) allocate(ALIGNMENT, comm->maxrecv * sizeof(MD_FLOAT)); 

  comm->maxneigh = NEIGHMIN;
  comm->nsend  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->nrecv  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->nexch  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_x  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_y  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_z  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->boxes  = (Box*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(Box));
  
  neighComm(comm, map, param->cutneigh, (MD_FLOAT[3]){param->xprd, param->yprd, param->zprd}); 
}

void forwardComm(Comm* comm, Atom* atom, int iswap)
{ 
  int nrqst=0, offset=0, nsend=0, nrecv=0; 
  int pbc[3];
  int size = comm->forwardSize; 
  int maxrqst = comm->numneigh;
  MD_FLOAT* buf;
  MPI_Request requests[maxrqst];
  
  for(int ineigh = comm->sendfrom[iswap]; ineigh < comm->sendtill[iswap]; ineigh++){
    offset = comm->off_atom_send[ineigh];
    pbc[_x]=comm->pbc_x[ineigh]; pbc[_y]=comm->pbc_y[ineigh];  pbc[_z]=comm->pbc_z[ineigh];
    packForward(atom, comm->atom_send[ineigh], comm->sendlist[ineigh], &comm->buf_send[offset*size],pbc);
  }
   
  //Receives elements 
  if(comm->othersend[iswap])  
    for (int ineigh = comm->recvfrom[iswap]; ineigh< comm->recvtill[iswap]; ineigh++){      
      offset = comm->off_atom_recv[ineigh]*size;
      nrecv  = comm->atom_recv[ineigh]*size;
      MPI_Irecv(&comm->buf_recv[offset], nrecv, type, comm->nrecv[ineigh],0,world,&requests[nrqst++]);
    }
   
  //Send elements 
  if(comm->othersend[iswap]) 
    for (int ineigh = comm->sendfrom[iswap]; ineigh< comm->sendtill[iswap]; ineigh++){  
      offset = comm->off_atom_send[ineigh]*size;
      nsend  = comm->atom_send[ineigh]*size;
      MPI_Send(&comm->buf_send[offset],nsend,type,comm->nsend[ineigh],0,world);      
    } 

  if(comm->othersend[iswap]) MPI_Waitall(nrqst,requests,MPI_STATUS_IGNORE);
  
  if(comm->othersend[iswap]) buf = comm->buf_recv;
  else buf = comm->buf_send;
  
  /* unpack buffer */   
  for (int ineigh = comm->recvfrom[iswap]; ineigh< comm->recvtill[iswap]; ineigh++){
    offset = comm->off_atom_recv[ineigh];
    unpackForward(atom, comm->atom_recv[ineigh], comm->firstrecv[iswap] + offset, &buf[offset*size]);
  }
}

void reverseComm(Comm* comm, Atom* atom, int iswap)
{ 
  int nrqst=0, offset=0, nsend=0, nrecv=0 ;
  int size = comm->reverseSize; 
  int maxrqst = comm->numneigh;
  MD_FLOAT* buf;
  MPI_Request requests[maxrqst];

  for(int ineigh = comm->recvfrom[iswap]; ineigh < comm->recvtill[iswap]; ineigh++){
    offset = comm->off_atom_recv[ineigh];
    packReverse(atom, comm->atom_recv[ineigh], comm->firstrecv[iswap] + offset, &comm->buf_send[offset*size]);
  }

  //Receives elements 
  if(comm->othersend[iswap])   
    for (int ineigh = comm->sendfrom[iswap]; ineigh< comm->sendtill[iswap]; ineigh++){      
      offset = comm->off_atom_send[ineigh]*size;
      nrecv  = comm->atom_send[ineigh]*size; 
      MPI_Irecv(&comm->buf_recv[offset], nrecv, type, comm->nsend[ineigh],0,world,&requests[nrqst++]);
    }

  //Send elements  
  if(comm->othersend[iswap]) 
    for (int ineigh = comm->recvfrom[iswap]; ineigh< comm->recvtill[iswap]; ineigh++){  
      offset = comm->off_atom_recv[ineigh]*size;
      nsend  = comm->atom_recv[ineigh]*size;  
      MPI_Send(&comm->buf_send[offset],nsend,type,comm->nrecv[ineigh],0,world);        
    } 

  if(comm->othersend[iswap]) MPI_Waitall(nrqst,requests,MPI_STATUS_IGNORE);
  if(comm->othersend[iswap])  buf = comm->buf_recv;
  else buf = comm->buf_send; 

  /* unpack buffer */   
  for (int ineigh = comm->sendfrom[iswap]; ineigh< comm->sendtill[iswap]; ineigh++){
    offset =  comm->off_atom_send[ineigh]; 
    unpackReverse(atom, comm->atom_send[ineigh], comm->sendlist[ineigh], &buf[offset*size]);
  }
}

void ghostComm(Comm* comm, Atom* atom,int iswap){

  MD_FLOAT xlo, xhi, ylo, yhi, zlo, zhi; 
  MD_FLOAT* buf;
  int nrqst=0, nsend=0, nrecv=0, offset=0, ineigh=0, pbc[3];
  int all_recv=0, all_send=0, ghostSize=0; 
  int size = comm->ghostSize; 
  int maxrqrst = comm->numneigh;
  MPI_Request requests[maxrqrst];
  
  if(iswap%2==0) comm->iterAtom = LOCAL+GHOST;
 
 
  for(int ineigh = comm->sendfrom[iswap]; ineigh< comm->sendtill[iswap]; ineigh++)
      {          
        Box* tile = &comm->boxes[ineigh];
        
        xlo = tile->lo[_x]; ylo = tile->lo[_y]; zlo = tile->lo[_z]; 
        xhi = tile->hi[_x]; yhi = tile->hi[_y]; zhi = tile->hi[_z];   
        pbc[_x]=comm->pbc_x[ineigh]; pbc[_y]=comm->pbc_y[ineigh];  pbc[_z]=comm->pbc_z[ineigh];
        nsend = 0; 

        for(int i = 0; i < comm->iterAtom ; i++) 
        { 
          if(IsinRegionToSend(i)){
                if(nsend >= comm->maxsendlist[ineigh]) growList(comm,ineigh,nsend);
                if(ghostSize >= comm->maxsend) growSend(comm,ghostSize); 
                comm->sendlist[ineigh][nsend++] = i;
                ghostSize += packGhost(atom, i, &comm->buf_send[ghostSize], pbc);  
          }   
        }
        comm->atom_send[ineigh]     = nsend;          //#atoms send per neigh   
        comm->off_atom_send[ineigh] = all_send;       //offset atom respect to neighbours in a swap
        all_send += nsend;                            //all atoms send
      }      
  //Receives how many elements to be received.
  if(comm->othersend[iswap]) 
    for(nrqst=0, ineigh = comm->recvfrom[iswap]; ineigh< comm->recvtill[iswap]; ineigh++)
      MPI_Irecv(&comm->atom_recv[ineigh],1,MPI_INT,comm->nrecv[ineigh],0,world,&requests[nrqst++]);
  if(!comm->othersend[iswap]) comm->atom_recv[comm->recvfrom[iswap]] = nsend;
        
  //Communicate how many elements to be sent.
  if(comm->othersend[iswap])
    for(int ineigh = comm->sendfrom[iswap]; ineigh< comm->sendtill[iswap]; ineigh++)
      MPI_Send(&comm->atom_send[ineigh],1,MPI_INT,comm->nsend[ineigh],0,world);    
   if(comm->othersend[iswap]) MPI_Waitall(nrqst,requests,MPI_STATUS_IGNORE);
 
  //Define offset to store in the recv_buff    
  for(int ineigh = comm->recvfrom[iswap]; ineigh<comm->recvtill[iswap]; ineigh++){ 
    comm->off_atom_recv[ineigh] = all_recv;
    all_recv += comm->atom_recv[ineigh];
  }

  if(all_recv*size>=comm->maxrecv) growRecv(comm,all_recv*size);

  //Receives elements 
  if(comm->othersend[iswap])
    for (nrqst=0, ineigh = comm->recvfrom[iswap]; ineigh< comm->recvtill[iswap]; ineigh++){
      offset = comm->off_atom_recv[ineigh]*size;  
      nrecv = comm->atom_recv[ineigh]*size;
      MPI_Irecv(&comm->buf_recv[offset], nrecv, type, comm->nrecv[ineigh],0,world,&requests[nrqst++]);
    } 

  //Send elements
  if(comm->othersend[iswap])
    for (int ineigh = comm->sendfrom[iswap]; ineigh< comm->sendtill[iswap]; ineigh++){
      offset = comm->off_atom_send[ineigh]*size;
      nsend  = comm->atom_send[ineigh]*size;  
      MPI_Send(&comm->buf_send[offset],nsend,type,comm->nsend[ineigh],0,world); 
    }
  if(comm->othersend[iswap]) MPI_Waitall(nrqst,requests,MPI_STATUS_IGNORE);
  
  if(comm->othersend[iswap]) buf = comm->buf_recv;
  else buf = comm->buf_send; 

  comm->firstrecv[iswap] = LOCAL+GHOST; 
  for(int i = 0; i < all_recv; i++)
    unpackGhost(atom, LOCAL+GHOST, &buf[i*size]);
}

void exchangeComm(Comm* comm, Atom* atom){

  int i, m, n, nsend, nrecv, nexch, nlocal, nrqst, offset; 
  MD_FLOAT value, pos, lo, hi;
  int size = comm->exchangeSize;  /*Number of paramters per atom, x,y,z,vx,vy,vz,type*/
  /* enforce PBC */
  pbc(atom);
  for(int dim = 0; dim < 3; dim++) {
    nrqst = 0;
    nexch = comm->exchtill[dim]-comm->exchfrom[dim]; 
    int offset_recv[nexch];
    int size_recv[nexch];
    MPI_Request requests[nexch];
    
    i = nsend = nrecv = 0;
    lo = atom->mybox.lo[dim];
    hi = atom->mybox.hi[dim];
    nlocal = atom->Nlocal;
    if(comm->exchfrom[dim] == comm->exchtill[dim]) continue;
    /* fill buffer with atoms leaving my box
    *        when atom is deleted, last atom is copied */
    while(i < nlocal) {
      pos = (dim==_x) ? atom_x(i) : (dim==_y) ? atom_y(i) : atom_z(i);
      if(pos < lo || pos >= hi) {
        if(nsend > comm->maxsend) growSend(comm, nsend);
        nsend += packExchange(atom, i, &comm->buf_send[nsend]);
        copy(atom, i, nlocal-1);
        nlocal--;
      } else i++;
    }
    atom->Nlocal = nlocal;

    /* send/recv number of to share atoms with neighbouring procs*/
    for(int ineigh = comm->exchfrom[dim]; ineigh < comm->exchtill[dim]; ineigh++) 
      MPI_Irecv(&size_recv[ineigh],1,MPI_INT,comm->nexch[ineigh],0,world,&requests[nrqst++]);

    for (int ineigh = comm->exchfrom[dim]; ineigh < comm->exchtill[dim]; ineigh++) 
      MPI_Send(&nsend,1,MPI_INT,comm->nexch[ineigh],0,world); 
    MPI_Waitall(nrqst,requests,MPI_STATUS_IGNORE);
 
    //Define offset to store in the recv_buff
    for(int ineigh = comm->exchfrom[dim]; ineigh<comm->exchtill[dim]; ineigh++){ 
        offset_recv[ineigh] = nrecv; 
        nrecv += size_recv[ineigh];
      }
 
    if(nrecv >= comm->maxrecv) growRecv(comm,nrecv); 
  
    //Receives elements 
    nrqst=0;
    for (int ineigh = comm->exchfrom[dim]; ineigh< comm->exchtill[dim]; ineigh++){
      offset = offset_recv[ineigh];
      MPI_Irecv(&comm->buf_recv[offset], size_recv[ineigh], type, comm->nexch[ineigh],0,world,&requests[nrqst++]);
    }

    //Send elements 
    for (int ineigh = comm->exchfrom[dim]; ineigh< comm->exchtill[dim]; ineigh++)
      MPI_Send(comm->buf_send,nsend,type,comm->nexch[ineigh],0,world); 
    MPI_Waitall(nrqst,requests,MPI_STATUS_IGNORE);  
 
    /* check incoming atoms to see if they are in my box
     *        if they are, add to my list */   
    n = atom->Nlocal;
    m = 0;
    while(m < nrecv) {
      value = comm->buf_recv[m + dim];
      if(value >= lo && value < hi){
        m += unpackExchange(atom, n++, &comm->buf_recv[m]);
      } else {
        m += size;
      }
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
  size_t oldByteSize = comm->maxsend*sizeof(MD_FLOAT)+BUFEXTRA;
  comm -> maxsend = (int) (BUFFACTOR * n);
  comm -> buf_send = (MD_FLOAT*) reallocate(comm->buf_send, ALIGNMENT, comm->maxsend * sizeof(MD_FLOAT) + BUFEXTRA, oldByteSize);
}

inline void growList(Comm* comm, int ineigh, int n)
{
  size_t oldByteSize = comm->maxsendlist[ineigh]*sizeof(int);
  comm->maxsendlist[ineigh] = (int) (BUFFACTOR * n);
  comm->sendlist[ineigh] = (int*) reallocate(comm->sendlist[ineigh],ALIGNMENT, comm->maxsendlist[ineigh] * sizeof(int), oldByteSize);
}

static inline void  initBuffers(Comm* comm)
{  
  //Buffers depending on the # of my neighs 
  int numneigh = comm->numneigh; 
  if(comm->atom_send) free(comm->atom_send);
  if(comm->atom_recv) free(comm->atom_recv);
  if(comm->off_atom_send) free(comm->off_atom_send);
  if(comm->maxsendlist) free(comm->maxsendlist);
  if(comm->sendlist){
    for(int i = 0; i < numneigh; i++) 
      if(comm->sendlist[i]) free(comm->sendlist[i]);
  } 
  if(comm->sendlist) free(comm->sendlist);
  
  comm->atom_send   = (int*) allocate(ALIGNMENT,  numneigh  * sizeof(int));
  comm->atom_recv   = (int*) allocate(ALIGNMENT,  numneigh * sizeof(int));
  comm->off_atom_send = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
  comm->off_atom_recv = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
  comm->maxsendlist   = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
 
  for(int i = 0; i < numneigh; i++) 
    comm->maxsendlist[i] = BUFMIN;
 
  comm->sendlist = (int**) allocate(ALIGNMENT, numneigh * sizeof(int*));
  for(int i = 0; i < numneigh; i++) 
    comm->sendlist[i] = (int*) allocate(ALIGNMENT, BUFMIN * sizeof(int));
}

static inline void freeBuffers(Comm* comm)
{
  if(comm->nrecv) free(comm->nrecv);
  if(comm->nsend) free(comm->nsend);
  if(comm->nexch) free(comm->nexch);  
  if(comm->pbc_x) free(comm->pbc_x); 
  if(comm->pbc_y) free(comm->pbc_y);  
  if(comm->pbc_z) free(comm->pbc_z);  
  if(comm->boxes) free(comm->boxes);  
  if(comm->atom_send) free(comm->atom_send);     
  if(comm->atom_recv) free(comm->atom_recv);   
  if(comm->off_atom_send) free(comm->off_atom_send); 
  if(comm->off_atom_recv) free(comm->off_atom_recv);
  if(comm->maxsendlist) free(comm->maxsendlist); 
  
  if(comm->sendlist){
    for(int i = 0; i < comm->numneigh; i++) 
      if(comm->sendlist[i]) free(comm->sendlist[i]); 
  }
  if(comm->sendlist) free(comm->sendlist);

  if(comm->buf_send) free(comm->buf_send); 
  if(comm->buf_recv) free(comm->buf_recv);   
}


