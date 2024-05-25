#CONFIGURE BUILD SYSTEM
TAG = $(OPT_TAG)-$(TOOL_TAG)-$(DATA_TYPE)
TARGET	   = MDBench-$(TAG)
BUILD_DIR  = ./build/build-$(TAG)
SRC_ROOT   = src
SRC_DIR    = $(SRC_ROOT)/$(OPT_SCHEME)
COMMON_DIR = $(SRC_ROOT)/common
MAKE_DIR   = ./make
Q         ?= @

#DO NOT EDIT BELOW
include config.mk
include $(MAKE_DIR)/include_$(TOOLCHAIN).mk
include $(MAKE_DIR)/include_LIKWID.mk
INCLUDES  += -I$(CURDIR)/$(SRC_DIR) -I$(CURDIR)/$(COMMON_DIR)

VPATH     = $(SRC_DIR) $(COMMON_DIR) $(CUDA_DIR)
ASM       = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.c))
OBJ       = $(filter-out $(BUILD_DIR)/main%, $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.c)))
OBJ      += $(patsubst $(COMMON_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(COMMON_DIR)/*.c))
ifeq ($(strip $(TOOLCHAIN)),NVCC)
OBJ      += $(patsubst $(SRC_DIR)/%.cu, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.cu))
endif
SOURCES   =  $(wildcard $(SRC_DIR)/*.h $(SRC_DIR)/*.c $(COMMON_DIR)/*.c $(COMMON_DIR)/*.h)
CPPFLAGS := $(CPPFLAGS) $(DEFINES) $(OPTIONS) $(INCLUDES)
c := ,
clist = $(subst $(eval) ,$c,$(strip $1))

define CLANGD_TEMPLATE
CompileFlags:
  Add: [$(call clist,$(INCLUDES)), $(call clist,$(CPPFLAGS))]
  Compiler: clang
endef

ifneq ($(VARIANT),)
	.DEFAULT_GOAL := ${TARGET}-$(VARIANT)
    DEFINES += -DVARIANT=$(VARIANT)
endif

${TARGET}: $(BUILD_DIR) .clangd $(OBJ) $(SRC_DIR)/main.c
	@echo "===>  LINKING  $(TARGET)"
	$(Q)${LINKER} $(CPPFLAGS) ${LFLAGS} -o $(TARGET) $(SRC_DIR)/main.c $(OBJ) $(LIBS)

${TARGET}-%: $(BUILD_DIR) $(OBJ) $(SRC_DIR)/main-%.c
	@echo "===>  LINKING  $(TARGET)-$* "
	$(Q)${LINKER} $(CPPFLAGS) ${LFLAGS} -o $(TARGET)-$* $(SRC_DIR)/main-$*.c $(OBJ) $(LIBS)

$(BUILD_DIR)/%.o:  %.c
	$(info ===>  COMPILE  $@)
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $@ -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%.o:  %.cu
	$(info ===>  COMPILE  $@)
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $@ -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%.s:  %.c
	$(info ===>  GENERATE ASM  $@)
	$(Q)$(CC) -S $(ASFLAGS) $(CPPFLAGS) $(CFLAGS) $< -o $@

$(BUILD_DIR)/%.o:  %.s
	$(info ===>  ASSEMBLE  $@)
	$(Q)$(AS) $< -o $@

.PHONY: clean distclean cleanall tags format info asm

clean:
	$(info ===>  CLEAN)
	@rm -rf $(BUILD_DIR)

cleanall:
	$(info ===>  CLEAN)
	@rm -rf build
	@rm -rf MDBench-*
	@rm -f tags .clangd

distclean: clean
	$(info ===>  DIST CLEAN)
	@rm -f $(TARGET)
	@rm -f tags .clangd

info:
	$(info $(CFLAGS))
	$(Q)$(CC) $(VERSION)

asm:  $(BUILD_DIR) $(ASM)

tags:
	$(info ===>  GENERATE  TAGS)
	$(Q)ctags -R

format:
	@for src in $(SOURCES) ; do \
		echo "Formatting $$src" ; \
		clang-format -i $$src ; \
	done
	@echo "Done"

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

.clangd:
	$(file > .clangd,$(CLANGD_TEMPLATE))

-include $(OBJ:.o=.d)
