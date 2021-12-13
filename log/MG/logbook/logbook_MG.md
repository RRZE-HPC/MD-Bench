<!-----------------------------------------------------------------------------
This document should be written based on the Github flavored markdown specs:
https://github.github.com/gfm/
It can be converted to html or pdf with pandoc:
pandoc -s -o logbook.html  -f gfm -t html logbook.md
pandoc test.txt -o test.pdf
or with the kramdown converter:
kramdown --template document  -i GFM  -o html logbook.md

Optional: Document how much time was spent. A simple python command line tool
for time tracking is [Watson](http://tailordev.github.io/Watson/).
------------------------------------------------------------------------------>

# MuCoSim: Analysis of MD-Bench CUDA port from C

## Project Description

### Customer Info

* Name: Maximilian Gaul
* E-Mail: [maximilian.gaul@fau.de](mailto:maximilian.gaul@fau.de)

### Application Info

* Code: MD-Bench
* URL: https://github.com/RRZE-HPC/MD-Bench/tree/mucosim_cuda

Performance analysis of MD-Bench, a molecular dynamics application which calculates the interactions among particles and how these affect their motion.
The simulation system's constituents are
* Number of atoms with initial state (position & velocity)
* Boundary conditions (periodic)

The force of each atom is based on its interaction with neighboring atoms. In MD-Bench, the Lennard-Jones potential is used to model the potential among
pairs of particles, here: electronically neutral atoms. This potential models repulsive as well as attractive interactions:

<p align="center">
  <img src="https://github.com/RRZE-HPC/MD-Bench/blob/mucosim_cuda/log/MG/resources/d7cacc33b0cedf5b4aa171cd20e4af9931ed38e2.svg" />
</p>

where ***r*** is the distance between the two interacting atoms, ***ε*** is the dispersion energy and ***σ*** the distance at which the
particle-potential ***V*** is zero:

<p align="center">
  <img src="https://github.com/RRZE-HPC/MD-Bench/blob/mucosim_cuda/log/MG/resources/320px-Graph_of_Lenanrd-Jones_potential.png" />
</p>

What can be observed from this graph is:
* The Lennard-Jones potential is a simplified model but still describes the essential aspects of particle dynamics
* Particles repel each other at close distances, attract each other at medium distances and have close to zero interaction at large distances

The main focus of this logbook is to describe the performance behavior of *force.c* where the force between atoms is actually calculated.
Calculating the force means iterating over every pair of particle, which is done in the main-loop (pseudo-code):

```python
for atom in atoms:
    neighbors = neighbor.neighbors[atom]
    force = 0.0
    for neighbor in neighbors:
        radius = calc_radius(...)
        if radius < close_enough:
            force += calc_force(...)
    forces[atom] += force
```

The original C-code will be refactored to an Nvidia CUDA compatible kernel function and its performance will be evaluated via *Nvidia Nsight System*.

### Testsystem

* Host/Clustername: tinyGPU.tg086
* Cluster Info URL: <https://hpc.fau.de/systems-services/systems-documentation-instructions/clusters/tinygpu-cluster/>
* CPU type: 2x Intel Xeon Gold 6226R @2.9 GHz = 32 cores with optional SMT
* GPU type: 8x NVIDIA Geforce RTX3080
* Memory capacity: 384 GB RAM
* Number of GPUs per node: 7/56
  
<!-----------------------------------------------------------------------------
Describe the system you are using for your tests
------------------------------------------------------------------------------>

### Software Environment

**Compiler**:

* Compiler: Nvidia NVCC Build cuda_11.2.r11.2/compiler.29618528_0
* Operating System: Ubuntu 20.04.3 LTS

<!-----------------------------------------------------------------------------
Describe the build system
------------------------------------------------------------------------------>


### How to build software
```console
foo@bar:~$ git clone https://github.com/RRZE-HPC/MD-Bench/tree/mucosim_cuda
foo@bar:~$ cd MD-Bench
```

Change the `TAG` variable in `config.mk` to `TAG ?= NVCC`
You can adjust compiler flags in `include_NVCC.mk`.

### Testcase description

<!-----------------------------------------------------------------------------
Describe the test case like input sizes, runtime configurations, ...
------------------------------------------------------------------------------>
### How to run software

```console
foo@bar:~/MD-Bench$ module load cuda likwid
foo@bar:~/MD-Bench$ make
foo@bar:~/MD-Bench$ ./MDBench-NVCC
```

MD-Bench will output the temperature and pressure at fixed iterations intervalls
as well as performance evaluations in million atom updates per second.
An output may look like this (without modified parameters):
```console
foo@bar:~$ ./MDBench-NVCC
step    temp            pressure
0       1.440000e+00    1.215639e+00
100     8.200895e-01    6.923143e-01
200     7.961495e-01    6.721043e-01
----------------------------------------------------------------------------
Force field: lj
Data layout for positions: AoS
Using double precision floating point.
----------------------------------------------------------------------------
System: 131072 atoms 47265 ghost atoms, Steps: 200
TOTAL 6.83s FORCE 0.73s NEIGH 3.07s REST 3.04s
----------------------------------------------------------------------------
Performance: 3.84 million atom updates per second
```

With

```console
foo@bar:~/MD-Bench$ ./MDBench-NVCC -h
MD Bench: A minimalistic re-implementation of miniMD
----------------------------------------------------------------------------
-f <string>:          force field (lj or eam), default lj
-i <string>:          input file for EAM
-n / --nsteps <int>:  set number of timesteps for simulation
-nx/-ny/-nz <int>:    set linear dimension of systembox in x/y/z direction
--freq <real>:        processor frequency (GHz)
--vtk <string>:       VTK file for visualization
----------------------------------------------------------------------------
```

you can observe the available command line arguments.

## Task1: Scaling runs
<!-----------------------------------------------------------------------------
Run the application in a controlled environment from one to all hardware thread. 
Take the system topology into account (NUMA domains, CPU sockets, ...).
Record a metric like runtime, performance, ... for each run and plot it
------------------------------------------------------------------------------>

To better understand how to scale CUDA code appropriately, we first have to familiarize
ourselfs with the CUDA programming model.

The basic execution size is a `thread` which is executed by one CUDA core.
Threads are group together in `blocks`. These are then executed by one streaming multiprocessor *SM*.
Once a block gets distributed to an SM, resources are allocated on a `warp`-size level,
which is 32 threads. These warps are then dispatched to execution units of the GPU.

Therefore, it could make sense to use blocks with multiple of 32 threads.

The CUDA library doesn't really allow to limit the number of CUDA cores which are used for execution,
therefore we show how the performance of MD-Bench changes with increasing number of threads per block.

Each MD-Bench run will execute 50 time steps, which is equal to 50 calls to *computeForce()* .

Because the number of atom-updates is constant with `131072`, the number of blocks
therefore results in:

```python
blocks = ceil( 131072 / num_threads )
```

```console
foo@bar:~/MD-Bench$ srun.tinygpu -N 1 -n 1 --gres=gpu:1 --pty /bin/bash -l
foo@@tg082:~MD-Bench$ NUM_THREADS=1 ./MD-Bench NVCC -n 50
```

Via the code

```C
int nDevices;
cudaGetDeviceCount(&nDevices);

for(int i = 0; i < nDevices; ++i) {
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, i);
    printf("DEVICE NAME: %s\r\n", prop.name);
}
```

we are able to observe, that the system has one `RTX 3080`:

```console
DEVICE NAME: NVIDIA GeForce RTX 3080
```

TODO: Add GPU measurements

As one can see, the performance improvement with increasing thread count stagnates at around 10 threads per block
and there is no clear benefit of choosing 32 over 10 threads.

This is probably due to memory bandwidth limitations between CPU and GPU.
As only the *computeForce()* was ported to the GPU, there has to happen a lot of copying of atom data to the GPU memory
before computation and back to the CPU after computation is finished.

For CPU:

srun.tinyfat --ntasks=1 --cpus-per-task=32 --pty /bin/bash -l

TODO: Add CPU measurements with OMP

## Task2: Whole application measurements

<!--
    TODO:
        - Calculate atom updates / second for various thread / block configurations
        - Calculate memory bandwith cpu <-> gpu by computing bytes / second in 'computeForce' call
        - Calculate flops / second for GPU
        - Calculate roofline model
 >
<!-----------------------------------------------------------------------------
Redo the scaling runs but measure the application behavior with useful metrics
------------------------------------------------------------------------------>

To evaluate memory bandwith between CPU and GPU we measure the transfer duration of the whole neighbor list, which is
52428800 bytes (or 50 Mbyte).

One such transfer roughly takes 0.015s, which extrapolates to around 5 Gbyte/s.

After calculation is done, copying the results back to the CPU is performed at 4 Gbyte/s.

Using `nvprof` via the command

```console
nvprof --print-gpu-trace ./MDBench-NVCC -n 50
```

we can observe how much time is actually spent in each specific cuda related code:

   Start  Duration            Grid Size      Block Size     Regs*    SSMem*    DSMem*      Size  Throughput  SrcMemType  DstMemType           Device   Context    Stream  Name
1.00263s  899.68us                    -               -         -         -         -  4.1199MB  4.4719GB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00404s  87.904us                    -               -         -         -         -  1.0000MB  11.109GB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00439s  87.616us                    -               -         -         -         -  1.0000MB  11.146GB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00490s  87.808us                    -               -         -         -         -  1.0000MB  11.122GB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00515s  60.640us                    -               -         -         -         -  703.13KB  11.058GB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00522s     896ns                    -               -         -         -         -      128B  136.24MB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00523s     864ns                    -               -         -         -         -      128B  141.29MB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00524s     864ns                    -               -         -         -         -      128B  141.29MB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.00576s  11.534ms                    -               -         -         -         -  50.000MB  4.2335GB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.01758s  45.248us                    -               -         -         -         -  512.00KB  10.791GB/s    Pageable      Device  NVIDIA GeForce          1         7  [CUDA memcpy HtoD]
1.01763s  19.917ms          (65536 1 1)         (2 1 1)        38        0B        0B         -           -           -           -  NVIDIA GeForce          1         7  calc_force() [132]
1.03757s  80.896us                    -               -         -         -         -  1.0000MB  12.072GB/s      Device    Pageable  NVIDIA GeForce          1         7  [CUDA memcpy DtoH]
1.03786s  80.736us                    -               -         -         -         -  1.0000MB  12.096GB/s      Device    Pageable  NVIDIA GeForce          1         7  [CUDA memcpy DtoH]
1.03815s  80.480us                    -               -         -         -         -  1.0000MB  12.134GB/s      Device    Pageable  NVIDIA GeForce          1         7  [CUDA memcpy DtoH]

Using yet another NVIDIA profiling tool, `nsys` we can get a more detailed overview with

```console
nsys profile --stats=true -o nsys_profile ./MDBench-NVCC -n 50
```

CUDA API Statistics:

 Time(%)  Total Time (ns)  Num Calls    Average      Minimum     Maximum            Name         
 -------  ---------------  ---------  ------------  ----------  ----------  ---------------------
    45.6      788,616,166         51  15,463,062.1  14,117,057  19,881,561  cudaDeviceSynchronize
    44.4      767,944,973        663   1,158,288.0       4,058  28,160,881  cudaMemcpy           
     5.9      101,436,382        510     198,894.9       2,735   7,753,209  cudaFree             
     4.0       69,728,615        510     136,722.8       3,450   3,335,759  cudaMalloc           
     0.1        1,422,216         51      27,886.6      22,843      74,387  cudaLaunchKernel     


CUDA Kernel Statistics:

 Time(%)  Total Time (ns)  Instances    Average      Minimum     Maximum                                 Name                             
 -------  ---------------  ---------  ------------  ----------  ----------  --------------------------------------------------------------
   100.0      787,497,765         51  15,441,132.6  14,094,494  19,849,202  calc_force(Atom, double, double, double, int, int, int*, int*)

Analyizing the output profile in `NVIDIA Nsight Systems`:

TODO: Add image

We can dig even deeper using even more NVIDIA tools such as `NVIDIA Nsight Compute`.

Via `ncu --set full -o profile ./MDBench-NVCC` we get very detaild and nicely presented analysis results, such as a Roofline model plot:

TODO: Add image

OVERALL TODO AFTER FIRST TALK:

- Consider Pinned memory instead of pageable
- Reduce memory overhead
-- Only copy neighborlist after it has been updated (every n-th iteration or so - can be parametrized)
- Implement SoA
- Port other parts of the code to CUDA
- Detailed measurements of kernel function (force calculation) (e.g. Cache utilization)
-- Do the same thing for CPU

## Task3: Runtime profile

<!-----------------------------------------------------------------------------
Determine the functions/kernels which contribute the most to the runtime. Those
are candidates for optimizations.
------------------------------------------------------------------------------>

## Task4: Instrument kernels with MarkerAPI

<!-----------------------------------------------------------------------------
Mark the functions/kernels with instrumentation. Describe what is needed for that. What changes compared to the original setup? Any flags? Etc.
------------------------------------------------------------------------------>

## Task5: Measurements of the selected hot spots

<!-----------------------------------------------------------------------------
Redo the scaling runs but this time measure the hotspots.
------------------------------------------------------------------------------>

## Task6: Discussion of hot spot measurements

<!-----------------------------------------------------------------------------
Discuss the measurement results and think about optimizations that could
improve the performance. You do NOT need to implement and benchmark your approach
but, of course, you can to strengthen your arguments.
------------------------------------------------------------------------------>
