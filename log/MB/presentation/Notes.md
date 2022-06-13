
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
  * we will use only one gpu -> only get part of the cpus of one node

* Execution and default parameters
  * Compiler: Nvidia Cuda compiler with Cuda 11.6.1
  * Operating system: Ubuntu 20.04.3 LTS
  * Additionaly LIKWID 5.2.0
  
  * building:
    * clone repository
    * go into repo
    * switch to the mucosim-cuda branch
    * load likwid and cuda
    * compile

  * running (for example in a batch script):
    * load likwid and cuda
    * goto right folder
    * start MDBench-NVCC executable

* Testcase description:
  * 131k atoms (determined by earlier contributor to be maxing out the throughput)
  * DP for floating numbers
  * lennard jones potential for force computation
  * one gpu with its 16 cores is used
    * one thread per CPU since SMT is disabled

* Initial: CPU-Scaling Runs
  * take one gpu with its cores
  * scale the number of threads to see if that has an effect
  * effect is only limitied
  * performance converges quite quickly
  * convergence points for A40 SP and A100 both cases may hint at bottlenecks unrelated to the gpu

* Profiling the application
  * with nsys - Nvidia Nsight Systems
    * activity is cyclic: 
      * long parts with one CPU
      * then short burst of GPU activity
      * repeat
  * with gprof - to get a rough estimation where CPU runtime is spent (GPU time not recognized as such)
    * most of the time is spent building neighbor lists
  * with time readings taken inside the program
    * both CPU and GPU time are accounted for
    * same result: neighborhood calculation takes most time
    * -> why is that? have look at code
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
      * atomic CAS operation to avoid race conditions on that variable

* Thank you for your attention:
  * any questions?
  * any other ideas for parallelizing neighborhood calculation?
