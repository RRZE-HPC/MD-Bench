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

Performance Analysis of the MD-Bench mini-app, based on miniMD, focusing on providing a performance model for molecular dynamics.

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

<!-----------------------------------------------------------------------------
Create a runtime profile. Which tool was used? How was the profile created.
Describe and discuss the runtime profile.
------------------------------------------------------------------------------>
## Runtime Profile <NAME-TAG>-<ID>

<!-----------------------------------------------------------------------------
Perform a static code review.
------------------------------------------------------------------------------>
## Code review <NAME-TAG>-<ID>

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
