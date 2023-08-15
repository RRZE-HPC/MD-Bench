#CONFIGURE BUILD SYSTEM
TARGET	   = gather-bench-$(TAG)
BUILD_DIR  = ./$(TAG)
SRC_DIR	= ./src
MAKE_DIR   = ./
ISA_DIR	= ./src/$(ISA)
Q		 ?= @

#DO NOT EDIT BELOW
include $(MAKE_DIR)/config.mk
include $(MAKE_DIR)/include_$(TAG).mk
include $(MAKE_DIR)/include_LIKWID.mk
INCLUDES  += -I./src/includes

VPATH	 = $(SRC_DIR) ${ISA_DIR}
ASM	   = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.c))
ASM	  += $(patsubst $(SRC_DIR)/%.f90, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.f90))
OBJ	   = $(filter-out $(BUILD_DIR)/main%, $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.c)))
OBJ	  += $(patsubst $(SRC_DIR)/%.cc, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.cc))
OBJ	  += $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.cpp))
OBJ	  += $(patsubst $(SRC_DIR)/%.f90, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.f90))
OBJ	  += $(patsubst $(SRC_DIR)/%.F90, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.F90))
OBJ	  += $(patsubst $(SRC_DIR)/%.s, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.s))
OBJ	  += $(patsubst $(ISA_DIR)/%.S, $(BUILD_DIR)/%.o,$(wildcard $(ISA_DIR)/*.S))
CPPFLAGS := $(CPPFLAGS) $(DEFINES) $(INCLUDES) -DISA_$(ISA)

ifneq ($(VARIANT),)
	.DEFAULT_GOAL := ${TARGET}-$(VARIANT)
endif

ifeq ($(strip $(DATA_LAYOUT)),AOS)
    CPPFLAGS += -DAOS
endif

ifeq ($(strip $(TEST)),true)
    CPPFLAGS += -DTEST
endif

ifeq ($(strip $(PADDING)),true)
    CPPFLAGS += -DPADDING
endif

ifeq ($(strip $(MEASURE_GATHER_CYCLES)),true)
    CPPFLAGS += -DMEASURE_GATHER_CYCLES
endif

ifeq ($(strip $(ONLY_FIRST_DIMENSION)),true)
    CPPFLAGS += -DONLY_FIRST_DIMENSION
endif

ifeq ($(strip $(MEM_TRACER)),true)
    CPPFLAGS += -DMEM_TRACER
endif

${TARGET}: $(BUILD_DIR) $(OBJ) $(SRC_DIR)/main.c
	@echo "===>  LINKING  $(TARGET)"
	$(Q)${LINKER} ${CPPFLAGS} ${LFLAGS} -o $(TARGET) $(SRC_DIR)/main.c $(OBJ) $(LIBS)

${TARGET}-%: $(BUILD_DIR) $(OBJ) $(SRC_DIR)/main-%.c
	@echo "===>  LINKING  $(TARGET)-$* "
	$(Q)${LINKER} ${CPPFLAGS} ${LFLAGS} -o $(TARGET)-$* $(SRC_DIR)/main-$*.c $(OBJ) $(LIBS)

asm:  $(BUILD_DIR) $(ASM)

$(BUILD_DIR)/%.o:  %.c
	@echo "===>  COMPILE  $@"
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $(@:.d=.o) -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%.s:  %.c
	@echo "===>  GENERATE ASM  $@"
	$(Q)$(CC) -S $(CPPFLAGS) $(CFLAGS) $< -o $@

$(BUILD_DIR)/%.s:  %.f90
	@echo "===>  COMPILE  $@"
	$(Q)$(FC) -S  $(FCFLAGS) $< -o $@

$(BUILD_DIR)/%.o:  %.cc
	@echo "===>  COMPILE  $@"
	$(Q)$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@
	$(Q)$(CXX) $(CPPFLAGS) -MT $(@:.d=.o) -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%.o:  %.cpp
	@echo "===>  COMPILE  $@"
	$(Q)$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@
	$(Q)$(CXX) $(CPPFLAGS) -MT $(@:.d=.o) -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%.o:  %.f90
	@echo "===>  COMPILE  $@"
	$(Q)$(FC) -c  $(FCFLAGS) $< -o $@

$(BUILD_DIR)/%.o:  %.F90
	@echo "===>  COMPILE  $@"
	$(Q)$(FC) -c  $(CPPFLAGS)  $(FCFLAGS) $< -o $@

$(BUILD_DIR)/%.o:  %.s
	@echo "===>  ASSEMBLE  $@"
	$(Q)$(AS)  $(ASFLAGS) $< -o $@

$(BUILD_DIR)/%.o:  %.S
	@echo "===>  ASSEMBLE  $@"
	$(Q)$(CC) -c $(CPPFLAGS) $< -o $@

tags:
	@echo "===>  GENERATE  TAGS"
	$(Q)ctags -R


$(BUILD_DIR):
	@mkdir $(BUILD_DIR)

ifeq ($(findstring $(MAKECMDGOALS),clean),)
-include $(OBJ:.o=.d)
endif

.PHONY: clean distclean

clean:
	@echo "===>  CLEAN"
	@rm -rf $(BUILD_DIR)
	@rm -f tags

distclean: clean
	@echo "===>  DIST CLEAN"
	@rm -f $(TARGET)
	@rm -f tags
