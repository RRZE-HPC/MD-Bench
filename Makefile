#CONFIGURE BUILD SYSTEM
IDENTIFIER = $(OPT_SCHEME)-$(TAG)-$(ISA)-$(DATA_TYPE)
TARGET	   = MDBench-$(IDENTIFIER)
BUILD_DIR  = ./build-$(IDENTIFIER)
SRC_DIR    = ./$(OPT_SCHEME)
ASM_DIR    = ./asm
COMMON_DIR = ./common
CUDA_DIR   = ./$(SRC_DIR)/cuda
MAKE_DIR   = ./
Q         ?= @

#DO NOT EDIT BELOW
include $(MAKE_DIR)/config.mk
include $(MAKE_DIR)/include_$(TAG).mk
include $(MAKE_DIR)/include_LIKWID.mk
include $(MAKE_DIR)/include_ISA.mk
include $(MAKE_DIR)/include_GROMACS.mk
INCLUDES  += -I./$(SRC_DIR)/includes -I./$(COMMON_DIR)/includes

ifeq ($(strip $(OPT_SCHEME)),gromacs)
    DEFINES +=  -DGROMACS
endif
ifeq ($(strip $(DATA_LAYOUT)),AOS)
    DEFINES +=  -DAOS
endif
ifeq ($(strip $(DATA_TYPE)),SP)
    DEFINES +=  -DPRECISION=1
else
    DEFINES +=  -DPRECISION=2
endif

ifneq ($(ASM_SYNTAX), ATT)
    ASFLAGS += -masm=intel
endif

ifeq ($(strip $(SORT_ATOMS)),true)
    DEFINES += -DSORT_ATOMS
endif

ifeq ($(strip $(EXPLICIT_TYPES)),true)
    DEFINES += -DEXPLICIT_TYPES
endif

ifeq ($(strip $(MEM_TRACER)),true)
    DEFINES += -DMEM_TRACER
endif

ifeq ($(strip $(INDEX_TRACER)),true)
    DEFINES += -DINDEX_TRACER
endif

ifeq ($(strip $(COMPUTE_STATS)),true)
    DEFINES += -DCOMPUTE_STATS
endif

ifeq ($(strip $(XTC_OUTPUT)),true)
    DEFINES += -DXTC_OUTPUT
endif

ifeq ($(strip $(USE_REFERENCE_VERSION)),true)
    DEFINES += -DUSE_REFERENCE_VERSION
endif

ifeq ($(strip $(HALF_NEIGHBOR_LISTS_CHECK_CJ)),true)
    DEFINES += -DHALF_NEIGHBOR_LISTS_CHECK_CJ
endif

ifeq ($(strip $(DEBUG)),true)
    DEFINES += -DDEBUG
endif

ifneq ($(VECTOR_WIDTH),)
    DEFINES += -DVECTOR_WIDTH=$(VECTOR_WIDTH)
endif

ifeq ($(strip $(__SIMD_KERNEL__)),true)
    DEFINES += -D__SIMD_KERNEL__
endif

ifeq ($(strip $(__SSE__)),true)
    DEFINES += -D__ISA_SSE__
endif

ifeq ($(strip $(__ISA_AVX__)),true)
    DEFINES += -D__ISA_AVX__
endif

ifeq ($(strip $(__ISA_AVX_FMA__)),true)
    DEFINES += -D__ISA_AVX_FMA__
endif

ifeq ($(strip $(__ISA_AVX2__)),true)
    DEFINES += -D__ISA_AVX2__
endif

ifeq ($(strip $(__ISA_AVX512__)),true)
    DEFINES += -D__ISA_AVX512__
endif

ifeq ($(strip $(ENABLE_OMP_SIMD)),true)
    DEFINES += -DENABLE_OMP_SIMD
endif

ifeq ($(strip $(USE_SIMD_KERNEL)),true)
    DEFINES += -DUSE_SIMD_KERNEL
endif

VPATH     = $(SRC_DIR) $(ASM_DIR) $(CUDA_DIR)
ASM       = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.c))
OVERWRITE:= $(patsubst $(ASM_DIR)/%-new.s, $(BUILD_DIR)/%.o,$(wildcard $(ASM_DIR)/*-new.s))
OBJ       = $(filter-out $(BUILD_DIR)/main% $(OVERWRITE),$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.c)))
OBJ      += $(patsubst $(ASM_DIR)/%.s, $(BUILD_DIR)/%.o,$(wildcard $(ASM_DIR)/*.s))
OBJ      += $(patsubst $(COMMON_DIR)/%.c, $(BUILD_DIR)/%-common.o,$(wildcard $(COMMON_DIR)/*.c))
ifeq ($(strip $(TAG)),NVCC)
OBJ      += $(patsubst $(CUDA_DIR)/%.cu, $(BUILD_DIR)/%-cuda.o,$(wildcard $(CUDA_DIR)/*.cu))
endif
CPPFLAGS := $(CPPFLAGS) $(DEFINES) $(OPTIONS) $(INCLUDES)

# $(warning $(OBJ))

ifneq ($(VARIANT),)
	.DEFAULT_GOAL := ${TARGET}-$(VARIANT)
    DEFINES += -DVARIANT=$(VARIANT)
endif

${TARGET}: $(BUILD_DIR) $(OBJ) $(SRC_DIR)/main.c
	@echo "===>  LINKING  $(TARGET)"
	$(Q)${LINKER} $(CPPFLAGS) ${LFLAGS} -o $(TARGET) $(SRC_DIR)/main.c $(OBJ) $(LIBS)

${TARGET}-%: $(BUILD_DIR) $(OBJ) $(SRC_DIR)/main-%.c
	@echo "===>  LINKING  $(TARGET)-$* "
	$(Q)${LINKER} $(CPPFLAGS) ${LFLAGS} -o $(TARGET)-$* $(SRC_DIR)/main-$*.c $(OBJ) $(LIBS)

$(BUILD_DIR)/%.o:  %.c
	$(info ===>  COMPILE  $@)
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $@ -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%-common.o:  $(COMMON_DIR)/%.c
	$(info ===>  COMPILE  $@)
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $@ -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%-cuda.o:  %.cu
	$(info ===>  COMPILE  $@)
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $@ -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%.s:  %.c
	$(info ===>  GENERATE ASM  $@)
	$(Q)$(CC) -S $(ASFLAGS) $(CPPFLAGS) $(CFLAGS) $< -o $@

$(BUILD_DIR)/%.o:  %.s
	$(info ===>  ASSEMBLE  $@)
	$(Q)$(AS) $< -o $@

.PHONY: clean distclean tags info asm

clean:
	$(info ===>  CLEAN)
	@rm -rf $(BUILD_DIR)
	@rm -rf $(TARGET)*
	@rm -f tags

cleanall:
	$(info ===>  CLEAN)
	@rm -rf build-*
	@rm -rf MDBench-*
	@rm -f tags

distclean: clean
	$(info ===>  DIST CLEAN)
	@rm -f $(TARGET)*
	@rm -f tags

info:
	$(info $(CFLAGS))
	$(Q)$(CC) $(VERSION)

asm:  $(BUILD_DIR) $(ASM)

tags:
	$(info ===>  GENERATE  TAGS)
	$(Q)ctags -R

$(BUILD_DIR):
	@mkdir $(BUILD_DIR)

-include $(OBJ:.o=.d)
