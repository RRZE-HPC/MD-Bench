<!-----------------------------------------------------------------------------
This document should be written based on the Github flavored markdown specs:
https://github.github.com/gfm/
It can be converted to html or pdf with pandoc:
pandoc -s -o logbook.html  -f gfm -t html logbook.md
pandoc test.txt -o test.pdf
or with the kramdown converter:
kramdown --template document  -i GFM  -o html logbook.md

If checked in as part of a github project html is automatically generated if
using the github web interface.

Optional: Document how much time was spent. A simple python command line tool
for time tracking is [Watson](http://tailordev.github.io/Watson/).
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
The Agenda section is a scratchpad area for planning and Todo list
------------------------------------------------------------------------------>
# Agenda

* Gather behavior:
    * What makes gathers slower?
        * Latency (distance between data and registers)
        * Cut cache lines between gathers for each dimension (gather on y dimension may require different cache line than for x)
        * Mapping between data and cache sets (most cache lines can be mapped to only a few cache sets)
    * Compare cache simulator with measurements from likwid (1 timestep)
    * Allow flexible behavior on gather-md to simulate "random" accesses:
        * Use strides and distance output from MD-Bench as input on gather-md
        * Use one config for all gather iterations (i.e. specifiy 8 strides on double-precisiong AVX512 version)
    * Histogram for distances between neighbors to be gathered
* Evaluate the impact of disabling prefetchers on standard case
* Compare HW. vs SW. gather strategies
* Implement EAM potential


<!-- ![Plot title](figures/example.png "ALT Text") -->

<!-----------------------------------------------------------------------------
START BLOCK PREAMBLE -  Global information required in all steps: Add all
information required to build and benchmark the application. Should be extended
and maintained during the project.
------------------------------------------------------------------------------>
# Project Description

* Start date: DD/MM/YYYY
* Ticket ID:
* Home HPC center:
* Contact HPC center:
   * Name: Rafael Ravedutti Lucio Machado
   * Fon: +49 9131 85 67296
   * E-Mail: rafael.r.ravedutti@fau.de

<!-----------------------------------------------------------------------------
Formulate a clear and specific performance target
------------------------------------------------------------------------------>
## Target

Performance analysis of the MD-Bench, a molecular dynamics mini-app based on miniMD. The main goal is to provide a performance model for molecular dynamics and evaluate the performance for different strategies on different targets.

<!-----------------------------------------------------------------------------
## Customer Info

* Name: <CUSTOMERNAME>
* E-Mail: john.doe@foo.bar
* Fon: <PHONENUMBER>
* Web: <URL>
------------------------------------------------------------------------------>

## Application Info

* Name: MD-Bench
* Domain: Molecular Dynamics
* Version: <VERSION>

<!-----------------------------------------------------------------------------
All steps required to build the software including dependencies
------------------------------------------------------------------------------>
## How to build software
* See README.md.
* Additional notes on the build process:
* **Used Compiler:**  
    * Intel Compiler - icc (ICC) 19.0.5.281 20190815
* **Compiler options:**
    * AVX512: -Ofast -xCORE-AVX512 -qopt-zmm-usage=high
    * AVX2: -fast -xCORE-AVX2

<!-----------------------------------------------------------------------------
Describe in detail how to configure and setup the testcases(es)
------------------------------------------------------------------------------>
## Testcase description

There are two test cases available:

* **Standard:** Standard setup from miniMD (Cu FCC lattice), atoms are evenly distributed on unit cells (4 atoms per unit cell), and each atom contains about 64 neighbors on average. The number of unit cells can be specified as input parametes, the default is to run a system of 32x32x32 unit cells.

* **Stubbed:** Version to execute within cache sizes, the number of atoms per unit cells and the number of unit cells per dimensions can be specified. All atoms are just neighbors to other atoms in the same unit cell, hence the number of neighbors per atom is fixed as the number of atoms per unit cells minus 1. This allow us to derive some properties such as the ones described in the following picture:

![Stubbed Force Calculation](figures/stubbed_force_mdbench.png)

<!-----------------------------------------------------------------------------
All steps required to run the testcase and control affinity for application
------------------------------------------------------------------------------>
## How to run software

To compile the application, adjust the configurations in the `config.mk` file and use the `make` command, this generates the `MD-Bench-TAG` binary that runs the standard test cases. `TAG` specifies the compiler to be used and it can be either GCC, CLANG or ICC. To compile the stubbed force calculation, simply run `make VARIANT=md`, which generates the `MD-Bench-TAG-stub` binary. The available options for both binaries can be seen with the `-h` option.

<!-----------------------------------------------------------------------------
END BLOCK PREAMBLE
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
START BLOCK ANALYST - This block is required for any new analyst taking over
the project
# Transfer to Analyst: <NAME-TAG>

* Start date: DD/MM/YYYY
* Contact HPC center:
   * Name:
   * Fon:
   * E-Mail:
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
###############################################################################
START BLOCK BENCHMARKING - Run helper script machine-state.sh and store results
in directory session-<ID> named <hostname>.txt. Document everything that you
consider to be relevant for performance.
###############################################################################
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
## Benchmarking <NAME-TAG>

### Testsystem

* Host/Clustername:
* Cluster Info URL:
* CPU type:
* Memory capacity:
* Number of cores per node:
* Interconnect:

### Software Environment

**Compiler**:
* Vendor:
* Version:

**Libraries**:
* <LIBRARYNAME>:
   * Version:

**OS**:
* Distribution:
* Version:
* Kernel version:
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
Create a runtime profile. Which tool was used? How was the profile created.
Describe and discuss the runtime profile.
------------------------------------------------------------------------------>
## Runtime Profile <NAME-TAG>-<ID>

The structure of the main simulation loop is the following:

```C
for(int n = 0; n < param.ntimes; n++) {
  initialIntegrate(&param , &atom);
  if((n + 1) % param.every) {
    updatePbc(&atom, &param);
  } else {
    reneighbour(&param, &atom, &neighbor);
  }
  computeForce(&param, &atom , &neighbor);
  finalIntegrate (&param , &atom);
  if(!((n + 1) % param.nstat ) && (n + 1) < param.ntimes) {
    computeThermo(n + 1, &param , &atom);
  }
}
```

From complexity analysis, we should expect that the `reneighbour` and `computeForce` stages to be the most performance-critical ones.
For the runtime profile we print the time results for each stage separately, as this is also done in the original miniMD application.
Furthermore, the results displayed on casclakesp2 with array of structures (AoS) layout with AVX512 compilation flags are:

```
TOTAL 9.30s FORCE 4.81s NEIGH 4.25s REST 0.24s
```

This confirms our hypothesis, in this case the force computation is the most expensive part.
However, this can change according to the rebuild frequency and force-field used in the simulation.
Also, optimizing the force computation will turn the neighbor list creation to consume a bigger fraction of the overall time, hence both stages should be considered and properly optimized for efficient MD simulations.

<!-----------------------------------------------------------------------------
Perform a static code review.
------------------------------------------------------------------------------>
## Code review <NAME-TAG>-<ID>

To compute the forces, the code must traverse through all atoms in the system and their neighbors.
The force is computed for every pair of atoms and accumulated into the current atom's position.
Since we use the neighbor lists approach, the iteration over the neighbors is simply the iteration over the current atoms list.
The code can be seen below:

```C
for(int i = 0; i < Nlocal; i++) {
    neighs = &neighbor->neighbors[i * neighbor->maxneighs];
    int numneighs = neighbor->numneigh[i];
    MD_FLOAT xtmp = atom_x(i);
    MD_FLOAT ytmp = atom_y(i);
    MD_FLOAT ztmp = atom_z(i);
    MD_FLOAT fix = 0;
    MD_FLOAT fiy = 0;
    MD_FLOAT fiz = 0;

    for(int k = 0; k < numneighs; k++) {
        int j = neighs[k];
        MD_FLOAT delx = xtmp - atom_x(j);
        MD_FLOAT dely = ytmp - atom_y(j);
        MD_FLOAT delz = ztmp - atom_z(j);
        MD_FLOAT rsq = delx * delx + dely * dely + delz * delz;

        if(rsq < cutforcesq) {
            MD_FLOAT sr2 = 1.0 / rsq;
            MD_FLOAT sr6 = sr2 * sr2 * sr2 * sigma6;
            MD_FLOAT force = 48.0 * sr6 * (sr6 - 0.5) * sr2 * epsilon;
            fix += delx * force;
            fiy += dely * force;
            fiz += delz * force;
        }
    }

    fx[i] += fix;
    fy[i] += fiy;
    fz[i] += fiz;
}
```

To vectorize the code in the most internal loop, the data for the neighbors must be gathered into the vectors.
Consequently, instructions such as **vgather** or other that mimic its behavior must be used.
We resort to these strategies as hardware and software gathers, respectively.
In order to understand and detail the performance aspects of gathering the data for these kernels, we developed gather-bench (https://github.com/RRZE-HPC/gather-bench), a benchmark that performs gathering of data from arrays of different sizes in order to evaluate the L1, L2 and L3 cache scenarios.
The benchmark provides a simple array case and MD variants using Array of Structs (AoS) and Struct of Arrays (SoA) data layouts.

Additionaly to understanding the memory latency and bandwidth impacts, we also need to evaluate how the kernel executes on the CPU with respect to instruction throughput.
For that, we use the already mentioned stubbed force calculation, a benchmark that contains well known data access behavior and fixed amount of neighbors per atom.
This allow us to make the data size fit into the L1 cache (reduce latency impact) and derive some properties such as the number of cycles per atom.
Finally, we compare the executed measurements from the stubbed force calculation with OSACA and IACA predictions for the same kernel as a baseline.

For the Intel compiler generated assembly, three variants of the most three internal loop are generated (Consider ***rmng_neighs = numneighs - k***):

- **rmng\_neighs < 8:** last iteration, vectors are not fulfilled
- **rmng\_neighs in ]8, 1200]:** with lea+mov instructions (prefetching?), L1 case? 1200 * 3 * 8 =28.8kB, L1 cache size is 32kB on Cascade Lake
- **rmng\_neighs >= 1200:** no mov+lea instructions

Unless explicitly stated, our experiments make use of the **rmng\_neighs in ]8, 1200]** variant!

Regarding the mov+lea instructions, these can be perceived in the following snippet:

```Assembly
vmovdqu   ymm3, YMMWORD PTR [r13+rbx*4]         # ymm3 <- neighs[k]
vpaddd    ymm4, ymm3, ymm3                      # ymm4 <- neighs[k] * 2
vpaddd    ymm3, ymm3, ymm4                      # ymm3 <- neighs[k] * 3
# -------------------- mov+lea instructions (prefetching?) -----------------------
mov       r10d, DWORD PTR [r13+rbx*4]           # r10d <- neighs[k]
mov       r9d, DWORD PTR [4+r13+rbx*4]          # r9d  <- neighs[k + 1]
mov       r8d, DWORD PTR [8+r13+rbx*4]          # r8d  <- neighs[k + 2]
mov       esi, DWORD PTR [12+r13+rbx*4]         # esi  <- neighs[k + 3]
lea       r10d, DWORD PTR [r10+r10*2]           # r10d <- neighs[k] * 3
mov       ecx, DWORD PTR [16+r13+rbx*4]         # ecx  <- neighs[k + 4]
lea       r9d, DWORD PTR [r9+r9*2]              # r9d  <- neighs[k + 1] * 3
mov       edx, DWORD PTR [20+r13+rbx*4]         # edx  <- neighs[k + 5]
lea       r8d, DWORD PTR [r8+r8*2]              # r8d  <- neighs[k + 2] * 3
mov       eax, DWORD PTR [24+r13+rbx*4]         # edx  <- neighs[k + 6]
lea       esi, DWORD PTR [rsi+rsi*2]            # esi  <- neighs[k + 3] * 3
mov       r15d, DWORD PTR [28+r13+rbx*4]        # edx  <- neighs[k + 7]
lea       ecx, DWORD PTR [rcx+rcx*2]            # ecx  <- neighs[k + 4] * 3
lea       edx, DWORD PTR [rdx+rdx*2]            # edx  <- neighs[k + 5] * 3
lea       eax, DWORD PTR [rax+rax*2]            # eax  <- neighs[k + 6] * 3
lea       r15d, DWORD PTR [r15+r15*2]           # r15d <- neighs[k + 7] * 3
# -------------------- end of mov+lea instructions -------------------------------
vpcmpeqb  k1, xmm0, xmm0                        # k1    <- [true for all elements]
vpcmpeqb  k2, xmm0, xmm0                        # k2    <- [true for all elements]
vpcmpeqb  k3, xmm0, xmm0                        # k3    <- [true for all elements]
vpxord    zmm4, zmm4, zmm4                      # zmm4  <- 0.0
vpxord    zmm17, zmm17, zmm17                   # zmm17 <- 0.0
vpxord    zmm18, zmm18, zmm18                   # zmm18 <- 0.0
vgatherdpd zmm4{k1}, QWORD PTR [16+rdi+ymm3*8]  # zmm4  <- atom->x[j * 3 + 2]
vgatherdpd zmm17{k2}, QWORD PTR [8+rdi+ymm3*8]  # zmm17 <- atom->x[j * 3 + 1]
vgatherdpd zmm18{k3}, QWORD PTR [rdi+ymm3*8]    # zmm18 <- atom->x[j * 3]
```

The mov+lea instructions delimited do not interfere with the semantics of the code (the dest registers for lea are not used afterwards in the kernel), hence they are generated either by compilation faults or performance reasons.
On Cascade Lake, the performance results when removing these instructions are better:

```
With lea+mov:
TOTAL 9.30s FORCE 4.81s NEIGH 4.25s REST 0.24s
Without lea+mov:
TOTAL 8.95s FORCE 4.43s NEIGH 4.28s REST 0.24s
```

Therefore at least for this case, we can assure that it is a bad compiler decision to generate such instructions.

<!-----------------------------------------------------------------------------
Application benchmarking runs. What experiment was done? Add results or
reference plots in directory session-<NAME-TAG>-<ID>. Number all sections
consecutivley such that every section has a unique ID.
------------------------------------------------------------------------------>
## Result MD-Bench-stub

### Problem: Execution contribution

We want to obtain the execution contribution for the LJ kernel with the best memory transfer scenario (all data served from L1).
Hence we ran our stubbed force calculation version and obtain the following measurements:

### Measurement MD-Bench-stub.1

Experiments executed on Cascade Lake with AoS data layout:

![Stubbed Force AoS Cascade Lake](figures/md_stub_aos_casclakesp2.png)

### Measurement MD-Bench-stub.2

Experiments executed on Cascade Lake with SoA data layout:

![Stubbed Force SoA Cascade Lake](figures/md_stub_soa_casclakesp2.png)

### Measurement MD-Bench-stub.3

Results reported by OSACA for CLX architecture with AoS data layout:

```
Combined Analysis Report
------------------------
                                     Port pressure in cycles                                     
     |  0   - 0DV  |  1   |  2   -  2D  |  3   -  3D  |  4   |  5   |  6   |  7   ||  CP  | LCD  |
-------------------------------------------------------------------------------------------------
 261 |             |      |             |             |      |      |      |      ||      |      |   ..B1.25:                        # Preds ..B1.24
 262 |             |      |             |             |      |      |      |      ||      |      |   # Execution count [4.50e+00]
 263 | 0.00        | 0.00 |             |             |      | 0.00 | 1.00 |      ||  1.0 |  1.0 |   movq      %r8, %r13                                     #56.43
 264 |             | 1.00 |             |             |      |      |      |      ||  3.0 |  3.0 |   imulq     %rcx, %r13                                    #56.43
 265 |             |      |             |             |      | 1.00 |      |      ||      |      |   vbroadcastsd %xmm6, %zmm2                               #58.23
 266 |             |      |             |             |      | 1.00 |      |      ||      |      |   vbroadcastsd %xmm7, %zmm1                               #59.23
 267 |             |      |             |             |      | 1.00 |      |      ||      |      |   vbroadcastsd %xmm12, %zmm0                              #60.23
...
 337 | 1.00        |      |             |             |      | 0.00 |      |      ||      |      |   vfmadd231pd %zmm23, %zmm25, %zmm9{%k2}                  #78.17
 338 | 1.00        |      |             |             |      | 0.00 |      |      ||      |      |   vfmadd231pd %zmm24, %zmm25, %zmm8{%k2}                  #79.17
 339 | 1.00        |      |             |             |      | 0.00 |      |      ||  4.0 |      |   vfmadd231pd %zmm26, %zmm25, %zmm11{%k2}                 #80.17
 340 | 0.00        | 0.00 |             |             |      | 0.00 | 1.00 |      ||      |      |   cmpl      %r14d, %r12d                                  #67.9
 341 |             |      |             |             |      |      |      |      ||      |      | * jb        ..B1.26       # Prob 82%                      #67.9
 342 |             |      |             |             |      |      |      |      ||      |      |   # LOE rbx rbp rdi r13 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14

       21.0          11.2   17.0   6.50   17.0   6.50   7.00   17.0   8.83   7.00    75.0   10.0 


Loop-Carried Dependencies Analysis Report
-----------------------------------------
 287 |  6.0 | lea       (%r10,%r10,2), %r10d                          #69.36| [269, 283, 287]
 291 | 10.0 | lea       (%r8,%r8,2), %r8d                             #69.36| [263, 264, 269, 285, 291]
 295 |  9.0 | lea       (%rcx,%rcx,2), %ecx                           #69.36| [264, 269, 288, 295]
 314 |  1.0 | addl      $8, %r12d                                     #67.9| [314]
 339 |  4.0 | vfmadd231pd %zmm26, %zmm25, %zmm11{%k2}                 #80.17| [339]
 338 |  4.0 | vfmadd231pd %zmm24, %zmm25, %zmm8{%k2}                  #79.17| [338]
 337 |  4.0 | vfmadd231pd %zmm23, %zmm25, %zmm9{%k2}                  #78.17| [337]
```

### Measurement MD-Bench-stub.4

Results reported by OSACA for CLX architecture with SoA data layout:

```
Combined Analysis Report
------------------------
                                     Port pressure in cycles                                     
     |  0   - 0DV  |  1   |  2   -  2D  |  3   -  3D  |  4   |  5   |  6   |  7   ||  CP  | LCD  |
-------------------------------------------------------------------------------------------------
 253 |             |      |             |             |      |      |      |      ||      |      |   # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm0 zmm1 zmm2 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
 254 |             |      |             |             |      |      |      |      ||      |      |   ..B1.22:                        # Preds ..B1.22 ..B1.21
 255 |             |      |             |             |      |      |      |      ||      |      |   # Execution count [2.50e+01]
 256 |             |      |             |             |      |      |      |      ||      |      | X vpcmpeqb  %xmm0, %xmm0, %k2                             #70.36
 257 | 0.00        | 0.50 |             |             |      | 0.00 | 0.50 |      ||      |      |   addl      $8, %r9d                                      #67.9
 258 |             |      |             |             |      |      |      |      ||      |      | X vpcmpeqb  %xmm0, %xmm0, %k1                             #69.36
 259 |             |      |             |             |      |      |      |      ||      |      | X vpcmpeqb  %xmm0, %xmm0, %k3                             #71.36
...
 289 | 0.00        |      |             |             |      | 1.00 |      |      ||      |      |   vfmadd231pd %zmm28, %zmm30, %zmm13{%k5}                 #78.17
 290 | 0.00        |      |             |             |      | 1.00 |      |      ||      |  4.0 |   vfmadd231pd %zmm29, %zmm30, %zmm12{%k5}                 #79.17
 291 | 0.00        |      |             |             |      | 1.00 |      |      ||  4.0 |      |   vfmadd231pd %zmm31, %zmm30, %zmm11{%k5}                 #80.17
 292 | 0.00        | 0.50 |             |             |      | 0.00 | 0.50 |      ||      |      |   cmpl      %ebx, %r9d                                    #67.9
 293 |             |      |             |             |      |      |      |      ||      |      | * jb        ..B1.22       # Prob 82%                      #67.9

       17.5          3.00   13.0   2.50   13.0   2.50          17.5   3.00           68.0    4   


Loop-Carried Dependencies Analysis Report
-----------------------------------------
 257 |  1.0 | addl      $8, %r9d                                      #67.9| [257]
 261 |  1.0 | addq      $8, %r14                                      #67.9| [261]
 290 |  4.0 | vfmadd231pd %zmm29, %zmm30, %zmm12{%k5}                 #79.17| [290]
 289 |  4.0 | vfmadd231pd %zmm28, %zmm30, %zmm13{%k5}                 #78.17| [289]
 291 |  4.0 | vfmadd231pd %zmm31, %zmm30, %zmm11{%k5}                 #80.17| [291]
```

### Measurement MD-Bench-stub.5

Results reported by IACA for SKX architecture with AoS data layout:

```
Throughput Analysis Report
--------------------------
Block Throughput: 36.70 Cycles       Throughput Bottleneck: Backend
Loop Count:  23
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles | 17.5     0.0  | 11.0  | 20.5    17.0  | 20.5    17.0  |  7.0  | 20.5  |  7.0  |  0.0  |
--------------------------------------------------------------------------------------------------
```

### Measurement MD-Bench-stub.6

Results reported by IACA for SKX architecture with SoA data layout:

```
Throughput Analysis Report
--------------------------
Block Throughput: 30.25 Cycles       Throughput Bottleneck: Backend
Loop Count:  23
Port Binding In Cycles Per Iteration:
--------------------------------------------------------------------------------------------------
|  Port  |   0   -  DV   |   1   |   2   -  D    |   3   -  D    |   4   |   5   |   6   |   7   |
--------------------------------------------------------------------------------------------------
| Cycles | 16.0     0.0  |  2.0  | 13.0    13.0  | 13.0    13.0  |  0.0  | 19.0  |  3.0  |  0.0  |
--------------------------------------------------------------------------------------------------
```

### Measurement MD-Bench-stub.7

![Stubbed Force AoS Cascade Lake Repeat 100 times](figures/md_stub_aos_casclakesp2_iln100.png)

### Measurement MD-Bench-stub.8

![Stubbed Force SoA Cascade Lake Repeat 100 times](figures/md_stub_soa_casclakesp2_iln100.png)

## Result gather-md

### Problem: Memory contribution

### Measurement gather-md.1

We want to obtain the memory contribution (bandwidth and latency) for gathering the data from atoms positions.
We used the **gather-md** benchmark and obtained the following measurements:

Experiments executed on Cascade Lake with AoS data layout:

![gather-md aos casclakesp2](figures/gather_md_aos_casclakesp2.png)
![gather-md aos casclakesp2](figures/gather_md_aos_casclakesp2_more_sizes.png)

### Measurement gather-md.2

Experiments executed on Cascade Lake with AoS data layout and padding byte:

![gather-md aos casclakesp2](figures/gather_md_aos_casclakesp2_padding.png)

### Measurement gather-md.3

Experiments executed on Cascade Lake with AoS data layout and no prefetchers:

![gather-md aos casclakesp2](figures/gather_md_aos_casclakesp2_no_prefetchers.png)

### Measurement gather-md.4

Experiments executed on Cascade Lake with AoS data layout only gathering data on x dimension:

![gather-md aos casclakesp2](figures/gather_md_aos_casclakesp2_one_dim.png)

### Measurement gather-md.5

Experiments executed on Cascade Lake with SoA data layout:

![gather-md soa casclakesp2](figures/gather_md_soa_casclakesp2.png)

### Measurement gather-md.6

Experiments executed on Ice Lake with AoS data layout:

![gather-md aos icx32](figures/gather_md_aos_icx32.png)
![gather-md aos icx32](figures/gather_md_aos_icx32_more_sizes.png)

### Measurement gather-md.7

Experiments executed on Ice Lake with AoS data layout and padding byte:

![gather-md aos icx32](figures/gather_md_aos_icx32_padding.png)

### Measurement gather-md.8

Experiments executed on Ice Lake with AoS data layout only gathering data on x dimension:

![gather-md aos icx32](figures/gather_md_aos_icx32_one_dim.png)

<!-----------------------------------------------------------------------------
Document the initial performance which serves as baseline for further progress
and is used to compute the achieved speedup. Document exactly how the baseline
was created.
## Baseline

* Time to solution:
* Performance:


------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
Explain which tool was used and how the measurements were done. Store and
reference the results. If applicable discuss and explain profiles.
## Performance Profile <NAME-TAG>-<ID>.2
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
Analysis and insights extracted from benchmarking results. Planning of more
benchmarks.
## Analysis <NAME-TAG>-<ID>.3
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
Document all changes with  filepath:linenumber and explanation what was changed
and why. Create patch if applicable and store patch in referenced file.
## Optimisation <NAME-TAG>-<ID>.4: <DESCRIPTION>
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
###############################################################################
END BLOCK BENCHMARKING
###############################################################################
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
Wrap up the final result and discuss the speedup.
Optional: Document how much time was spent. A simple python command line tool
for time tracking is [Watson](http://tailordev.github.io/Watson/).
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
## Summary

* Time to solution:
* Performance:
* Speedup:

## Effort

* Time spent:

------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
END BLOCK ANALYST
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
START BLOCK SUMMARY - This block is only required if multiple analysts worked
on the project.
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
# Overall Summary

* End date: DD/MM/YYYY

## Total Effort

* Total time spent:
* Estimated core hours saved:
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
END BLOCK SUMMARY
------------------------------------------------------------------------------>
