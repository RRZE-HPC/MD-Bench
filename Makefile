#CONFIGURE BUILD SYSTEM
TAG = $(OPT_TAG)-$(TOOLCHAIN)-$(DATA_TYPE)
TARGET	   = MDBench-$(TAG)
BUILD_DIR  = ./build/build-$(TAG)
SRC_ROOT   = ./src
SRC_DIR    = $(SRC_ROOT)/$(OPT_SCHEME)
COMMON_DIR = $(SRC_ROOT)/common
CUDA_DIR   = $(SRC_DIR)/cuda
MAKE_DIR   = ./make
Q         ?= @

#DO NOT EDIT BELOW
include config.mk
include $(MAKE_DIR)/include_$(TOOLCHAIN).mk
include $(MAKE_DIR)/include_LIKWID.mk
ifneq ($(strip $(ISA)),NONE)
include $(MAKE_DIR)/include_ISA.mk
endif
INCLUDES  += -I./$(SRC_DIR) -I./$(COMMON_DIR)

VPATH     = $(SRC_DIR) $(COMMON_DIR) $(CUDA_DIR)
ASM       = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.c))
OBJ       = $(filter-out $(BUILD_DIR)/main%, $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.c)))
OBJ      += $(patsubst $(COMMON_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(COMMON_DIR)/*.c))
ifeq ($(strip $(TAG)),NVCC)
OBJ      += $(patsubst $(CUDA_DIR)/%.cu, $(BUILD_DIR)/%-cuda.o,$(wildcard $(CUDA_DIR)/*.cu))
endif
CPPFLAGS := $(CPPFLAGS) $(DEFINES) $(OPTIONS) $(INCLUDES)

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

cleanall:
	$(info ===>  CLEAN)
	@rm -rf build
	@rm -rf MDBench-*
	@rm -f tags

distclean: clean
	$(info ===>  DIST CLEAN)
	@rm -f $(TARGET)
	@rm -f tags

info:
	$(info $(CFLAGS))
	$(Q)$(CC) $(VERSION)

asm:  $(BUILD_DIR) $(ASM)

tags:
	$(info ===>  GENERATE  TAGS)
	$(Q)ctags -R

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

-include $(OBJ:.o=.d)
