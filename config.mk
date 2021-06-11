# Supported: GCC, CLANG, ICC
TAG ?= ICC
ENABLE_LIKWID ?= false
# SP or DP
DATA_TYPE ?= DP
# AOS or SOA
DATA_LAYOUT ?= AOS

#Feature options
OPTIONS =  -DALIGNMENT=64
#OPTIONS +=  More options
