#CONFIGURE BUILD SYSTEM
TARGET	   = MDBench-$(TAG)-$(OPT_SCHEME)
BUILD_DIR  = ./$(TAG)-$(OPT_SCHEME)
SRC_DIR    = ./$(OPT_SCHEME)
ASM_DIR    = ./asm
MAKE_DIR   = ./
Q         ?= @

#DO NOT EDIT BELOW
include $(MAKE_DIR)/config.mk
include $(MAKE_DIR)/include_$(TAG).mk
include $(MAKE_DIR)/include_LIKWID.mk
include $(MAKE_DIR)/include_ISA.mk
include $(MAKE_DIR)/include_GROMACS.mk
INCLUDES  += -I./$(SRC_DIR)/includes

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

ifeq ($(strip $(DEBUG)),true)
    DEFINES += -DDEBUG
endif

ifneq ($(VECTOR_WIDTH),)
    DEFINES += -DVECTOR_WIDTH=$(VECTOR_WIDTH)
endif

ifeq ($(strip $(NO_AVX2)),true)
    DEFINES += -DNO_AVX2
endif

ifeq ($(strip $(AVX512)),true)
    DEFINES += -DAVX512
endif

VPATH     = $(SRC_DIR) $(ASM_DIR)
ASM       = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.c))
OVERWRITE:= $(patsubst $(ASM_DIR)/%-new.s, $(BUILD_DIR)/%.o,$(wildcard $(ASM_DIR)/*-new.s))
OBJ       = $(filter-out $(BUILD_DIR)/main% $(OVERWRITE),$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.c)))
OBJ      += $(patsubst $(ASM_DIR)/%.s, $(BUILD_DIR)/%.o,$(wildcard $(ASM_DIR)/*.s))
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
