# Supported: GCC, CLANG, ICC
TAG ?= GCC
DATA_TYPE ?= SP#SP or DP
DATA_LAYOUT ?= SoA#AOS or SOA

#Feature options
OPTIONS +=  -DALIGNMENT=64
