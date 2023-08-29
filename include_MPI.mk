CC   = mpicc
GCC  = gcc
LINKER = $(CC)

ifeq ($(ENABLE_OPENMP),true)
OPENMP   = -fopenmp
endif

VERSION  = 
CFLAGS   = -v -Ofast -mavx #-xHost #-qopt-zmm-usage=high  #-qopt-report-phase=all #-qopt-report=5 -qopt-report-phase:vec  -g -traceback   $(OPENMP) 
LFLAGS   = $(OPENMP)
DEFINES  = -D_GNU_SOURCE  -DVTK #-DVERBOSE  -DVERBOSE  #-DDEBUG  
INCLUDES =
LIBS     = -lmpi

#-xHost -qopt-streaming-stores=always -ffreestanding  -qopt-zmm-usage=high -xCORE-AVX2