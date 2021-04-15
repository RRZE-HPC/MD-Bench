#CONFIGURE BUILD SYSTEM
TARGET	   = MDBench-$(TAG)
BUILD_DIR  = ./$(TAG)
SRC_DIR    = ./src
MAKE_DIR   = ./
Q         ?= @

#DO NOT EDIT BELOW
include $(MAKE_DIR)/config.mk
include $(MAKE_DIR)/include_$(TAG).mk
INCLUDES  += -I./src/includes

ifeq ($(strip $(DATA_LAYOUT)),AOS)
DEFINES +=  -DAOS
endif
ifeq ($(strip $(DATA_TYPE)),SP)
DEFINES +=  -DPRECISION=1
else
DEFINES +=  -DPRECISION=2
endif

VPATH     = $(SRC_DIR)
ASM       = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.c))
OBJ       = $(filter-out $(BUILD_DIR)/main%,$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.c)))
CPPFLAGS := $(CPPFLAGS) $(DEFINES) $(OPTIONS) $(INCLUDES)

ifneq ($(VARIANT),)
	.DEFAULT_GOAL := ${TARGET}-$(VARIANT)
endif

${TARGET}: $(BUILD_DIR) $(OBJ) $(SRC_DIR)/main.c
	@echo "===>  LINKING  $(TARGET)"
	$(Q)${LINKER} $(CPPFLAGS) ${LFLAGS} -o $(TARGET) $(SRC_DIR)/main.c $(OBJ) $(LIBS)

${TARGET}-%: $(BUILD_DIR) $(OBJ) $(SRC_DIR)/main-%.c
	@echo "===>  LINKING  $(TARGET)-$* "
	$(Q)${LINKER} $(CPPFLAGS) ${LFLAGS} -o $(TARGET)-$* $(SRC_DIR)/main-$*.c $(OBJ) $(LIBS)

asm:  $(BUILD_DIR) $(ASM)

$(BUILD_DIR)/%.o:  %.c
	@echo "===>  COMPILE  $@"
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $(@:.d=.o) -MM  $< > $(BUILD_DIR)/$*.d

$(BUILD_DIR)/%.s:  %.c
	@echo "===>  GENERATE ASM  $@"
	$(Q)$(CC) -S $(ASFLAGS)  $(CPPFLAGS) $(CFLAGS) $< -o $@

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
	@rm -f $(TARGET)*
	@rm -f tags
