GROMACS_PATH=/apps/Gromacs/2018.1-mkl
GROMACS_INC ?= -I${GROMACS_PATH}/include
GROMACS_DEFINES ?=
GROMACS_LIB ?= -L${GROMACS_PATH}/lib64

ifeq ($(strip $(XTC_OUTPUT)),true)
INCLUDES += ${GROMACS_INC}
DEFINES +=  ${GROMACS_DEFINES}
LIBS += -lgromacs
LFLAGS += ${GROMACS_LIB}
endif
