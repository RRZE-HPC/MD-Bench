#ifndef COMM_H
#define COMM_H

#include <lammps/includes/atom.h> //Change here
#include <parameter.h>

typedef struct {
  MD_FLOAT lo[3];               //smallest coordinate of my subdomain
  MD_FLOAT hi[3];               //Highest coordinate of my subdomain
} Tile;

typedef struct {
  int myproc;                       // my proc ID
  int numproc;                      // # of processors
	
  int numneigh;                     // # of all my neighs along all swaps 
  int maxneigh;										  // Buffer size for my neighs
  int neighswap[6];							    // # of my neighs per swap
	int from[6];                      //return the lower neigh iter for a given swap
  int until[6];                     //return the upper neigh iter for a given swap
  int* neigh;											  // iD's of my neighs 
	  	
	int* pbc_x;                       // if pbc in x
	int* pbc_y;                       // if pbc in y
	int* pbc_z;                       // if pbc in z
	
  int* atom_send, *atom_recv;       // # of atoms to send/recv for each of my neighs
	int* size_send, *size_recv;       // # of values to send/recv for each of my neighs 
	int* off_atom_send;               // atom offset to send, inside of a swap
  int* off_atom_recv;               // atom offset to recv, inside of a swap
  
	int numswap;                      // # of swaps to perform, it is 6
  int swapdim[6]; 										// dimension of the swap (_x, _y or _z)
	int swapdir[6];										  // direction of the swap 0 or 1
  int swap[3][2];                  // given a dim and dir, knows the swap

	int* firstrecv[6];                   // where to put 1st recv atom in each swap
  int** sendlist;                   // list of atoms to send in each swap   
  int* maxsendlist;								  // max # of atoms send in each list-swap

	int maxsend;											// max elements in buff sender 									
	int maxrecv;											// max elements in buff receiver
  MD_FLOAT* buf_send;               // sender buffer for all comm
	MD_FLOAT* buf_recv;               // receicer buffer for all comm
	int* off_buff_send;               // value offset to send, inside of the send buffer
  int* off_buff_recv;               // value offset to recv, inside of the recv buffer
  	
	int size_for;					        		// # of paramaters per atom in forward comm.
	int size_rev;			        				// # of parameters per atom in reverse
  int size_exc;                     // # of parameters per atom in exchange
	
  Tile* tiles 											  // Boundaries to  be sent to other procs as ghost.
} Comm;


void initComm(int, char**, Comm*); 						      //Init MPI 
void endComm(Comm*);													      //End MPI
void setupComm(Comm*,Parameter*,Atom*,MD_FLOAT*);   //Creates a 3d grid
void forwardComm(Comm*,Atom*,int);							    //Send info in one direction
void reverseComm(Comm*,Atom*,int);							        //Return info after forward communication
void exchangeComm(Comm*,Atom*);							        //Exchange info between procs
void growSend(Comm*,int);										        //Grows the size of the buffer sender
void growRecv(Comm*,int);										        //Grows the size of the buffer receiver
void growList(Comm*, int, int);                     //Grows the size of the list to send

#endif