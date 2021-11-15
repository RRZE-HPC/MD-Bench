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

# MuCoSim: Analysis of <MyApplication>
[TOC]
## Project Description

### Customer Info

* Name: <MyName>
* E-Mail: [<myemail>](mailto:<myemail>)

### Application Info

* Code: <MyApplication>
* URL: <URL>


<!-----------------------------------------------------------------------------
Describe the application. Where does it come from? What is calculated? Why is it so important for HPC?
------------------------------------------------------------------------------>

### Testsystem

* Host/Clustername: icx36
* Cluster Info URL: <https://hpc.fau.de/systems-services/systems-documentation-instructions/clusters/test-cluster/>
* CPU type: 2x Intel Xeon Platinum 8360Y @ 2.4 GHz
* Memory capacity: 256 GB
* Number of cores per node: 72/144
* Interconnect: None
  
<!-----------------------------------------------------------------------------
Describe the system you are using for your tests
------------------------------------------------------------------------------>

### Software Environment

**Compiler**:

* Compiler: Intel Fortran 19.0.5.281
* MPI: Intel MPI Library 2019 Update 5
* Operating System: Ubuntu 20.04.3 LTS
* Addition libraries:
  * LIKWID 5.2.0

<!-----------------------------------------------------------------------------
Describe the build system
------------------------------------------------------------------------------>


### How to build software

<!-----------------------------------------------------------------------------
Which flags are you using? Any specific changes to the Makefile? 
------------------------------------------------------------------------------>

### Testcase description

<!-----------------------------------------------------------------------------
Describe the test case like input sizes, runtime configurations, ...
------------------------------------------------------------------------------>
### How to run software

<!-----------------------------------------------------------------------------
What is required to run the application
------------------------------------------------------------------------------>


## Task1: Scaling runs
<!-----------------------------------------------------------------------------
Run the application in a controlled environment from one to all hardware thread. 
Take the system topology into account (NUMA domains, CPU sockets, ...).
Record a metric like runtime, performance, ... for each run and plot it
------------------------------------------------------------------------------>
  
## Task2: Whole application measurements

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
