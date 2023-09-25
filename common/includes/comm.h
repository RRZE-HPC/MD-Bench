#include <atom.h>
#include <parameter.h>
#include <box.h>

#ifndef COMM_H
#define COMM_H

typedef struct {
  int myproc;                       // my proc ID
  int numproc;                      // # of processors
	
  int numneigh;                     // # of all my neighs along all swaps 
  int maxneigh;										  // Buffer size for my neighs
	int sendfrom[6];                  //return the lowest neigh index to send
  int sendtill[6];                  //return the highest neigh index to send
  int recvfrom[6];                  //return the lowest neigh index to recv 
  int recvtill[6];                  //return the highest neigh index to recv
  int* nsend;											  // neigh to send
  int* nrecv;                       // neigh to recv

	int* pbc_x;                       // if pbc in x
	int* pbc_y;                       // if pbc in y
	int* pbc_z;                       // if pbc in z
	
  int* atom_send, *atom_recv;       // # of atoms to send/recv for each of my neighs 
	int* off_atom_send;               // atom offset to send, inside of a swap
  int* off_atom_recv;               // atom offset to recv, inside of a swap
         
  int* nexch;                        //procs to exchange
  int exchfrom[3];                   //return the lowest neigh index to exhc
  int exchtill[3];                   //return the higuest neigh index to exch

	int numswap;                      // # of swaps to perform, it is 6
  int swapdim[6]; 									// dimension of the swap (_x, _y or _z)
	int swapdir[6];										// direction of the swap 0 or 1
  int swap[3][2];                   // given a dim and dir, knows the swap
  int othersend[6];                 // Determine if a proc interact with more procs in a given swap

	int* firstrecv[6];                   // where to put 1st recv atom in each swap
  int** sendlist;                   // list of atoms to send in each swap   
  int* maxsendlist;								  // max # of atoms send in each list-swap

	int maxsend;											// max elements in buff sender 									
	int maxrecv;											// max elements in buff receiver
  MD_FLOAT* buf_send;               // sender buffer for all comm
	MD_FLOAT* buf_recv;               // receicer buffer for all comm
	 	
	int forwardSize;					        // # of paramaters per atom in forward comm.
	int reverseSize;			        		// # of parameters per atom in reverse
  int exchangeSize;                 // # of parameters per atom in exchange
	int ghostSize;                    // # of parameters per atom in ghost list                               

  Box* boxes; 											 // Boundaries to  be sent to other procs as ghost.
} Comm;


void initComm(int, char**, Comm*); 						      //Init MPI 
void endComm(Comm*);													      //End MPI
void setupComm(Comm*,Parameter*,Atom*,MD_FLOAT*);   //Creates a 3d grid
void forwardComm(Comm*,Atom*,int);							    //Send info in one direction
void reverseComm(Comm*,Atom*,int);							    //Return info after forward communication
void exchangeComm(Comm*,Atom*);							        //Exchange info between procs
void ghostComm(Comm*, Atom*,int);                   //Build the ghost neighbours to send during next forwards
void growSend(Comm*,int);										        //Grows the size of the buffer sender
void growRecv(Comm*,int);										        //Grows the size of the buffer receiver
void growList(Comm*, int, int);                     //Grows the size of the list to send

#endif