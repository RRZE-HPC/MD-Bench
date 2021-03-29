#CONFIGURE BUILD SYSTEM
BUILD_DIR  = ./$(TAG)
SRC_DIR    = ./src/core
MAKE_DIR   = ./
Q         ?= @

TARGET_MDBENCH	   = MDBench-$(TAG)
TARGET_STUB        = stub

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
OBJ       = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.c))
CPPFLAGS := $(CPPFLAGS) $(DEFINES) $(OPTIONS) $(INCLUDES)

all: ${TARGET_MDBENCH} ${TARGET_STUB}

${TARGET_MDBENCH}: $(BUILD_DIR) $(OBJ) $(BUILD_DIR)/main.o
	@echo "===>  LINKING  $(TARGET_MDBENCH)"
	$(Q)${LINKER} ${LFLAGS} -o $(TARGET_MDBENCH) $(OBJ) $(BUILD_DIR)/main.o $(LIBS)

${TARGET_STUB}: $(BUILD_DIR) $(OBJ) $(BUILD_DIR)/stub.o
	@echo "===>  LINKING  $(TARGET_STUB)"
	$(Q)${LINKER} ${LFLAGS} -o $(TARGET_STUB) $(OBJ) $(BUILD_DIR)/stub.o $(LIBS)

asm:  $(BUILD_DIR) $(ASM)

$(BUILD_DIR)/main.o: ./src/main.c
	@echo "===>  COMPILE  $@"
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $(@:.d=.o) -MM  $< > $(BUILD_DIR)/main.d

$(BUILD_DIR)/stub.o: ./src/stub.c
	@echo "===>  COMPILE  $@"
	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@
	$(Q)$(CC) $(CPPFLAGS) -MT $(@:.d=.o) -MM  $< > $(BUILD_DIR)/stub.d

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
	@rm -f $(TARGET)
	@rm -f tags
