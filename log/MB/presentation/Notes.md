
* Initial
  * Hello and Welcome
* Project Description - What is MD-Bench?
  * original MD-Bench is on CPU written in around 1000 lines of code
  * MD-Bench on Cuda aims to port this to GPU -> use the massive parallelism of GPGPUs

  * Most of this model description taken from earlier contributors
  * Simulation Model:
    * interaction among particles
    * forces of these interaction & force effects on motion
    * consists of: 
      * atoms with initial state
      * boundary condition (here periodic) as shown in figure below
  * Particle interactions
    * uses lennard-jones potential:
      * simplified model but still describes essential aspects of particle dynamics
      * particles repel at close distances and attract at medium distances
      * close to zero at large distances -> cut of to save computation
  * Simulation process:
    * integrate force for each particle
    * every 20th timestep do a new calculation for the neighbor lists
    * for each atom 
      * iterate over all possible neighbors in its neighbor list
        * compute force if close enough
* Testsystem
  * alex
  * per node: 
    * 2x AMD Milan CPUs with 64 cores per CPU
    * 8 GPUs A40 or A100 

* Explanation for the runtime profile
  * force integration and force calculation are already on the GPU
    * short bursts of activity on the GPU
  * neighborhood calculation is still sequential on the CPU
    * long sequential part

  * parallelizing neighborhood calculation will probably speedup the application

* Parallelizing neighborhood calculation:
  * neighborhood calculation process:
    * multiple things to do:
      * update atoms that have left the simulation area
      * setup periodic boundary condition sets up ghost atoms
      * update_periodic_boundary_condition updates position of ghost atoms
  * Atoms near periodic border:
    * atoms near border can interact with atoms on the other side through periodic border
    * several ghost atoms per real atoms might be needed
    * looping through atoms and see what ghost atoms are needed
    * PARALLELIZING: iterations depend on each other via n_ghosts variable and the allocations
    * PARALLELIZING: DIFFICULTY: high, REWARD: probably low

  * building neighbor lists:
    * iterations over atoms are output dependent on each other iff neighbor
          lists are longer than the individually allocated space
