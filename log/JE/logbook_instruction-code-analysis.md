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

Example for referencing an image:

![Plot title](figures/example.png "ALT Text")

<!-----------------------------------------------------------------------------
START BLOCK PREAMBLE -  Global information required in all steps: Add all
information required to build and benchmark the application. Should be extended
and maintained during the project.
------------------------------------------------------------------------------>
# Project Description

* Start date: 09/07/2021
* Contact:
   * Name: Jan Eitzinger
   * E-Mail: jan.eitzinger@fau.de

<!-----------------------------------------------------------------------------
Formulate a clear and specific performance target
------------------------------------------------------------------------------>
## Target

Measure and analyse the runtime contribution from instruction execution in
the force calculation kernel. This is accomplished by implementing
a stubbed version of the MD loop that allows to control the data set size.
The size and loop counts are adjusted to minimise the influence of
pipeline startup effects and runtime contributions from data transfers.

In this document only the AVX512 SIMD variant is considered.


## Application Info

* Name:  MD-Bench
* Domain: Classical Molecular Dynamics
* Version: ??

<!-----------------------------------------------------------------------------
All steps required to build the software including dependencies
------------------------------------------------------------------------------>
## How to build software


<!-----------------------------------------------------------------------------
Describe in detail how to configure and setup the testcases(es)
------------------------------------------------------------------------------>
## Testcase description

<!-----------------------------------------------------------------------------
All steps required to run the testcase and control affinity for application
------------------------------------------------------------------------------>
## How to run software


<!-----------------------------------------------------------------------------
END BLOCK PREAMBLE
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
START BLOCK ANALYST - This block is required for any new analyst taking over
the project
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
###############################################################################
START BLOCK BENCHMARKING - Run helper script machine-state.sh and store results
in directory session-<ID> named <hostname>.txt. Document everything that you
consider to be relevant for performance.
###############################################################################
------------------------------------------------------------------------------>
## Benchmarking CascadeLake-stub

### Testsystem

* Host/Clustername: cascadelakesp2
* Cluster Info URL: RRZE Testcluster
* CPU type: Intel(R) Xeon(R) Gold 6248 CPU @ 2.50GHz
* Memory capacity: 386GB
* Number of sockets per node: 2
* Number of cores per socket: 20
* Number of threads per core: 2

### Software Environment

**Compiler**:
* Vendor:
* Version:

**OS**:
* Distribution:
* Version:
* Kernel version:

### Different code variants

MD-Bench allows to switch between two different data layouts. Most
properties in molecular dynamics have spatial dimensions. The two
possibilities to store those vectors is either array of structures (AOS),
here the small vectors are stored consecutivly; and structure of arrays
(SOA), here every component of the vectors are stored consecutivly in
memory.

The Intel compiler generates three different code branches for
different loop lengths of the inner neighbor list loop of the force
calculation routine:
* V1 `neighbor count < 8`
* V2 `neighbor count < 1200`
* V3 `neighbor count >= 1200`


<!-----------------------------------------------------------------------------
Perform a static code review.
------------------------------------------------------------------------------>
## Static code analysis <NAME-TAG>-<ID>

<!-----------------------------------------------------------------------------
Application benchmarking runs. What experiment was done? Add results or
reference plots in directory session-<NAME-TAG>-<ID>. Number all sections
consecutivley such that every section has a unique ID.
------------------------------------------------------------------------------>
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
## Summary

* Time to solution:
* Performance:
* Speedup:

## Effort

* Time spent:

<!-----------------------------------------------------------------------------
END BLOCK ANALYST
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
START BLOCK SUMMARY - This block is only required if multiple analysts worked
on the project.
------------------------------------------------------------------------------>
# Overall Summary

* End date: DD/MM/YYYY

## Total Effort

* Total time spent:
* Estimated core hours saved:

<!-----------------------------------------------------------------------------
END BLOCK SUMMARY
------------------------------------------------------------------------------>
