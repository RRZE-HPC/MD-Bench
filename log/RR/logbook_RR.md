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

* Finish this logbook with current state and results
* Understand gather-md behavior (AoS and SoA)
* Use cache simulator with application data access
    * How well do we use the gathers?
* Compare HW. vs SW. gather strategies
* Disable cache prefetchers
* Do the same evaluation and results for AVX2
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

From complexity analysis, we should expect that the `reneighbour` and `computeForce` stages should be the most performance-critical ones.
For the runtime profile we print the time results for each stage separately, as this is also done in the original miniMD application.
Furthermore, the results displayed on casclakesp2 with array of structures (AoS) layout with AVX512 compilation flags are:

```
TOTAL 9.30s FORCE 4.81s NEIGH 4.25s REST 0.24s
```

This confirms our hypothesis, in this case the force computation in the most expensive part.
However, this can change according to the rebuild frequency and force-field used in the simulation.
Besides, optimizing the force computation will turn the neighbor list creation to consume a bigger fraction of the overall time, hence both stages should be considered and properly optimized for efficient MD simulations.

<!-----------------------------------------------------------------------------
Perform a static code review.
------------------------------------------------------------------------------>
## Code review <NAME-TAG>-<ID>

<!-----------------------------------------------------------------------------
Application benchmarking runs. What experiment was done? Add results or
reference plots in directory session-<NAME-TAG>-<ID>. Number all sections
consecutivley such that every section has a unique ID.
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
## Result <NAME-TAG>-<ID>

### Problem: <DESCRIPTION>


### Measurement <NAME-TAG>-<ID>.1

Example for table:

| NP | runtime |
|----|---------|
| 1  | 2558.89 |
| 2  | 1425.20 |
| 4  | 741.97  |
| 8  | 449.23  |
| 10 | 371.39  |
| 20 | 233.90  |

```
Verbatim Text
```

------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
Document the initial performance which serves as baseline for further progress
and is used to compute the achieved speedup. Document exactly how the baseline
was created.
------------------------------------------------------------------------------>
## Baseline

* Time to solution:
* Performance:


<!-----------------------------------------------------------------------------
Explain which tool was used and how the measurements were done. Store and
reference the results. If applicable discuss and explain profiles.
------------------------------------------------------------------------------>
## Performance Profile <NAME-TAG>-<ID>.2

<!-----------------------------------------------------------------------------
Analysis and insights extracted from benchmarking results. Planning of more
benchmarks.
------------------------------------------------------------------------------>
## Analysis <NAME-TAG>-<ID>.3


<!-----------------------------------------------------------------------------
Document all changes with  filepath:linenumber and explanation what was changed
and why. Create patch if applicable and store patch in referenced file.
------------------------------------------------------------------------------>
## Optimisation <NAME-TAG>-<ID>.4: <DESCRIPTION>


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
