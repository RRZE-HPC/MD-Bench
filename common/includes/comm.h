#ifndef COMM_H
#define COMM_H

#include <atom.h>
#include <parameter.h>


typedef struct {
  MD_FLOAT xprd, yprd, zprd;    //dimensions of all domain
  MD_FLOAT xlo, xhi;            //smallest and biggest x of sub-domain processor
  MD_FLOAT ylo, yhi;            // same for y
  MD_FLOAT zlo, zhi;            // same for z
  MD_FLOAT len[3];               //lenght subdomain in each dimmension
} Box;

typedef struct {
  int myproc;                       // my proc ID
  int numproc;                      // # of processors
	int numswap;                      // # of swaps to perform
	int* pbc_flagx;                   // PBC correction in x for this swap
	int* pbc_flagy;                   // same in y
	int* pbc_flagz;                   // same in z
	int* sendnum, *recvnum;           // # of atoms to send/recv in each swap
	int* forward_send_size;           // # of values to send in each forward (Values = #Atoms * #dimensions) 
	int* forward_recv_size;           // # of values to recv in each forward
	int* reverse_send_size;           // # of values to send in each reverse
	int* reverse_recv_size;           // # of values to recv in each reverse
	int* sendproc, *recvproc;         // proc to send/recv with at each swap (swapping among closest neighbours)
  int* sendproc_exc, *recvproc_exc; // proc to send/recv with at each swap for safe exchange (exchanging among all neighbour inside the cutneigh)
  
	int* swapdim; 										// determine the direction of the swap (_x, _y or _z)
	int* swapdis;										  // determine the displacement of the swap in (_x, _y or _z)

	int* 	firstrecv;                  // where to put 1st recv atom in each swap
  int** sendlist;                   // list of atoms to send in each swap
	int* 	maxsendlist;								// max # of atoms send in each list-swap

	MD_FLOAT* buf_send;               // sender buffer for all comm
	MD_FLOAT* buf_recv;               // receicer buffer for all comm
	int maxsend;											// max elements in buff sender 									
	int maxrecv;											// max elements in buff receiver
	
	int atomSizeForward;							// # of paramaters per atom in forward comm.
	int atomSizeReverse;							// # of parameters per atom in reverse

	int procneigh[6];                 // my 6 proc neighbors
	int griddims[3];                  // # of processors in each dim
	int numneigh[3];                  // # of processors-neighbours covered by the cut neighbour
	MD_FLOAT* slablo, *slabhi;        // Boundaries to  be sent to other procs as ghost.
	
  Box mybox;                        //spatial representation of my processor box

} Comm;


void initComm(int, char**, Comm*, Parameter*); //Init MPI 
void endComm();															   //End MPI
void setupComm(MD_FLOAT,Comm*);				         //Creates a 3d grid
void forwardComm(Comm*,Atom*);							   //Send info in one direction
void reverseComm(Comm*,Atom*);							   //Return info after forward communication
void exchangeComm(Comm*,Atom*);							   //Exchange info between procs
void listComm(Comm*,Atom*);								     //Creates multiple list to send all neighbours
void growSend(Comm*,int);										   //Grows the size of the buffer sender
void growRecv(Comm*,int);										   //Grows the size of the buffer receiver
void growList(Comm*, int, int);                //Grows the size of the list to send

#endif