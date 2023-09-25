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

int inline isInSwap(Comm* comm, int swap, int proc)
{
  for(int i=comm->sendfrom[swap]; i<comm->sendtill[swap]; i++)
    if (proc == comm->nsend[i]) return 1; 
  return 0;
}

void neighComm(Comm *comm, MD_FLOAT *map, MD_FLOAT cutneigh, MD_FLOAT *prd)
{
  int me = comm->myproc; 
  int numproc = comm ->numproc;
  int PAD = 6;   //number of elements for processor in the map
  int ineigh = 0;
  Box mybox, other, tile;
  
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
      int pbc = overlapBox(dim,dir,&mybox,&other,&tile,prd[dim],cutneigh);
      if(pbc == -100) continue;   

      expandBox(iswap, &mybox, &other, &tile, cutneigh);
       
      if(ineigh > comm->maxneigh) {
          comm -> maxneigh  = (int) 2*ineigh;  
          comm -> nsend     = (int*) reallocate(comm->nsend, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->nsend));
          comm -> nrecv     = (int*) reallocate(comm->nrecv, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->nrecv));
          comm -> nexch     = (int*) reallocate(comm->nrecv, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->nrecv));
          comm -> pbc_x     = (int*) reallocate(comm->pbc_x, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->pbc_x));
          comm -> pbc_y     = (int*) reallocate(comm->pbc_y, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->pbc_y));
          comm -> pbc_z     = (int*) reallocate(comm->pbc_z, ALIGNMENT,  comm->maxneigh * sizeof(int), sizeof(comm->pbc_z));
          comm -> boxes     = (Box*) reallocate(comm->boxes, ALIGNMENT, comm->maxneigh * sizeof(Box), sizeof(comm->boxes));
        }
     
      comm->boxes[ineigh] = tile;  
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
 
  int index=0, iswap=0, dim=0, dir=0, invswap=0, duplicated=0, ineigh=0, i=0, myneigh=0; 

  comm->swap[_x][0] = 0; comm->swap[_x][1] =1;
  comm->swap[_y][0] = 2; comm->swap[_y][1] =3;
  comm->swap[_z][0] = 4; comm->swap[_z][1] =5;

  comm->swapdim[0] = comm->swapdim[1] = _x;
  comm->swapdim[2] = comm->swapdim[3] = _y;
  comm->swapdim[4] = comm->swapdim[5] = _z;

  comm->swapdir[0] = comm->swapdir[2] = comm->swapdir[4] = 0;
  comm->swapdir[1] = comm->swapdir[3] = comm->swapdir[5] = 1;
  
  comm->numneigh = 0;

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

  comm->forwardSize = 3;      //send coordiantes x,y,z
  comm->reverseSize = 3;      //return forces fx, fy, fz
  comm->ghostSize = 4;        //send x,y,z,type
  comm->exchangeSize = 7;     //send x,y,z,vx,vy,vz,type
  
  comm->maxneigh = NEIGHMIN;
  comm->maxsend = BUFMIN; 
  comm->maxrecv = BUFMIN;

  comm->nsend  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->nrecv  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->nexch  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_x  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_y  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->pbc_z  = (int*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(int));
  comm->boxes  = (Box*) allocate(ALIGNMENT,  comm->maxneigh * sizeof(Box));
  
  neighComm(comm, map, param->cutneigh, (MD_FLOAT[3]){param->xprd, param->yprd, param->zprd}); 
  initBuffers(comm);  

  //Set the inverse neighbour list
  for(iswap = 0; iswap<6; iswap++){
    dim = comm->swapdim[iswap]; 
    dir = comm->swapdir[iswap];
    invswap = comm->swap[dim][(dir+1)%2];   
    for(i = comm->sendfrom[invswap]; i< comm->sendtill[invswap]; i++)
      comm->nrecv[index++] = comm->nsend[i];  
    comm->recvfrom[iswap] = (iswap == 0) ? 0: comm->recvtill[iswap-1];
    comm->recvtill[iswap] = index;
  }

  //Set the exchange neighbour list
  for(index=0, dim = 0; dim<3; dim++)
  {
    int iswap0 = comm->swap[dim][0];  int iswap1 = comm->swap[dim][1]; duplicated=0;
    
    for (ineigh = comm->sendfrom[iswap0]; ineigh<comm->sendtill[iswap0]; ineigh++)
      comm->nexch[index++] = comm->nsend[ineigh];

    for(ineigh = comm->sendfrom[iswap1]; ineigh<comm->sendtill[iswap1]; ineigh++)
      if(!isInSwap(comm,iswap0,comm->nsend[ineigh])) comm->nexch[index++] = comm->nsend[ineigh];

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

void forwardComm(Comm* comm, Atom* atom, int iswap)
{
  int nrqst=0, offset=0, nsend=0, nrecv=0; 
  int pbc[3];
  int me = comm->myproc; 
  int dim = comm->swapdim[iswap];
  int dir = comm->swapdir[iswap];
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
  int dim = comm->swapdim[iswap];
  int dir = comm->swapdir[iswap];
  int size = comm->reverseSize; 
  int maxrqst = comm->numneigh;
  MD_FLOAT* buf;
  int me = comm->myproc; 
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

void ghostComm(Comm* comm, Atom* atom, int iswap)
{
  MD_FLOAT xlo, xhi, ylo, yhi, zlo, zhi; 
  MD_FLOAT* buf;
  int nrqst=0, nsend=0, nrecv=0, offset=0, ineigh=0, pbc[3];
  int all_recv=0, all_send=0, ghostSize=0; 
  int me = comm->myproc;
  int dim = comm->swapdim[iswap];
  int dir = comm->swapdir[iswap];
  int size = comm->ghostSize; 
  int maxrqrst = comm->numneigh;
  MPI_Request requests[maxrqrst];
     
  for(int ineigh = comm->sendfrom[iswap]; ineigh< comm->sendtill[iswap]; ineigh++)
      {          
        Box* tile = &comm->boxes[ineigh];
        
        xlo = tile->lo[_x]; ylo = tile->lo[_y]; zlo = tile->lo[_z]; 
        xhi = tile->hi[_x]; yhi = tile->hi[_y]; zhi = tile->hi[_z];   
        pbc[_x]=comm->pbc_x[ineigh]; pbc[_y]=comm->pbc_y[ineigh];  pbc[_z]=comm->pbc_z[ineigh];
        
        nsend = 0; 
        for(int i = 0; i < atom->Nlocal+atom->Nghost; i++) 
        {
          if (atom_x(i) >= xlo && atom_x(i) < xhi &&
              atom_y(i) >= ylo && atom_y(i) < yhi &&
              atom_z(i) >= zlo && atom_z(i) < zhi ) {  
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
  //printf("nsend:%i  sendto:%i, nrecv:%i, recvfrom:%i, iswap:%i, rank:%i\n",all_send,comm->nsend[comm->sendfrom[iswap]],all_recv,comm->nrecv[comm->sendfrom[iswap]],iswap,comm->myproc);
  if(comm->othersend[iswap]) buf = comm->buf_recv;
  else buf = comm->buf_send; 

  //printf("Sender Ghost: posx:%f, posy:%f, posz:%f, iswap%i, rank:%i\n",comm->buf_send[0],comm->buf_send[1],comm->buf_send[2],iswap,me);
  //printf("Recv Ghost: posx:%f, posy:%f, posz:%f, iswap%i, rank:%i\n",comm->buf_recv[0],comm->buf_recv[1],comm->buf_recv[2],iswap,me);

  comm->firstrecv[iswap] = atom->Nlocal + atom->Nghost;
  while(atom->Nlocal + all_recv >= atom->Nmax) growAtom(atom);

  for(int i = 0; i < all_recv; i++)
    unpackGhost(atom, atom->Nlocal+atom->Nghost, &buf[i*size]);

  //Ensure send buffer and recv buffer has enough space for forward and reverse
  int max = size * MAX(all_send, all_recv);
  if(max >= comm->maxsend) growSend(comm,max);
  if(max >= comm->maxrecv) growRecv(comm,max);
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
    int index = comm->exchfrom[dim];
    if(comm->myproc == comm->nexch[index]) continue;

    i = nsend = nrecv = 0;
    lo = atom->mybox.lo[dim];
    hi = atom->mybox.hi[dim];
    nlocal = atom->Nlocal;

    /* fill buffer with atoms leaving my box
    *        when atom is deleted, fill it in with last atom */
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
   
    /* send/recv atoms in both directions
    only if neighboring procs are different */
    
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

    //Receives elements as long as the # elements is non zero
    nrqst=0;
    for (int ineigh = comm->exchfrom[dim]; ineigh< comm->exchtill[dim]; ineigh++){
      offset = offset_recv[ineigh];
      MPI_Irecv(&comm->buf_recv[offset], size_recv[ineigh], type, comm->nexch[ineigh],0,world,&requests[nrqst++]);
    }
      
    //Sent elements as long as the # elements is no zero
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
  comm->off_atom_send = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
  comm->off_atom_recv = (int*) allocate(ALIGNMENT,numneigh * sizeof(int));
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
  free(comm->nrecv);
  free(comm->nsend);
  free(comm->nexch);  
  free(comm->pbc_x); 
  free(comm->pbc_y);  
  free(comm->pbc_z);  
  free(comm->boxes);  
  free(comm->atom_send);     
  free(comm->atom_recv);   
  free(comm->off_atom_send); 
  free(comm->off_atom_recv);
  free(comm->maxsendlist); 
 
  for(int i = 0; i < comm->numneigh; i++) 
    free(comm->sendlist[i]); 
  free(comm->sendlist);

  free(comm->buf_send); 
  free(comm->buf_recv);   
}


