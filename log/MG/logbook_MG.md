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

The original C-code will be refactored to Nvidia CUDA compatible code and its performance will be evaluated via *Nvidia Nsight System*.

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
