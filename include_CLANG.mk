CC  = cc
CXX = cc
LINKER = $(CC)

ANSI_CFLAGS  = -ansi
ANSI_CFLAGS += -std=c99
ANSI_CFLAGS += -pedantic
ANSI_CFLAGS += -Wextra

CFLAGS   = -O2 -g  #$(ANSI_CFLAGS)
ASFLAGS  = -masm=intel
CXXFLAGS = $(CFLAGS)
FCFLAGS  =
LFLAGS   =
DEFINES  = -D_GNU_SOURCE
INCLUDES =
LIBS     =
