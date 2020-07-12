CRTS= \
	$(BUILD_DIRECTORY_LIBS)/crt0.o \
	$(BUILD_DIRECTORY_LIBS)/crti.o \
	$(BUILD_DIRECTORY_LIBS)/crtn.o

$(BUILD_DIRECTORY_LIBS)/crt0.o: libraries/crt0.s
	$(DIRECTORY_GUARD)
	@echo [AS] $^
	@$(AS) $(ASFLAGS) -o $@ $^

$(BUILD_DIRECTORY_LIBS)/crti.o: libraries/crti.s
	$(DIRECTORY_GUARD)
	@echo [AS] $^
	@$(AS) $(ASFLAGS) -o $@ $^

$(BUILD_DIRECTORY_LIBS)/crtn.o: libraries/crtn.s
	$(DIRECTORY_GUARD)
	@echo [AS] $^
	@$(AS) $(ASFLAGS) -o $@ $^

ABI_HEADERS = \
	$(wildcard libraries/abi/*.h) \
	$(wildcard libraries/abi/*/*.h)

HEADERS += $(patsubst libraries/%, $(BUILD_DIRECTORY_INCLUDE)/%, $(ABI_HEADERS))

define LIB_TEMPLATE =

$(1)_ARCHIVE = $(BUILD_DIRECTORY_LIBS)/lib$($(1)_NAME).a
$(1)_SOURCES = \
	$$(wildcard libraries/lib$($(1)_NAME)/*.c) \
	$$(wildcard libraries/lib$($(1)_NAME)/*/*.c)

$(1)_OBJECTS = $$(patsubst libraries/%.c, $(BUILD_DIRECTORY)/%.o, $$($(1)_SOURCES))

$(1)_HEADERS = \
	$$(wildcard libraries/lib$($(1)_NAME)/*.h) \
	$$(wildcard libraries/lib$($(1)_NAME)/*/*.h)

TARGETS += $$($(1)_ARCHIVE)
OBJECTS += $$($(1)_OBJECTS)
ICONS += $$($(1)_ICONS)

# Special case for libcompat to copy the headers to the right location without the libcompat prefix.
ifneq ($(1), COMPAT)
HEADERS += $$(patsubst libraries/%, $(BUILD_DIRECTORY_INCLUDE)/%, $$($(1)_HEADERS))
else
HEADERS += $$(patsubst libraries/libcompat/%, $(BUILD_DIRECTORY_INCLUDE)/%, $$($(1)_HEADERS))
endif

$$($(1)_ARCHIVE): $$($(1)_OBJECTS)
	$$(DIRECTORY_GUARD)
	@echo [LIB$(1)] [AR] $$@
	@$(AR) $(ARFLAGS) $$@ $$^

$(BUILD_DIRECTORY)/lib$($(1)_NAME)/%.o: libraries/lib$($(1)_NAME)/%.c
	$$(DIRECTORY_GUARD)
	@echo [LIB$(1)] [CC] $$<
	@$(CC) $(CFLAGS) $($(1)_CFLAGS) -c -o $$@ $$<

endef

$(BUILD_DIRECTORY_INCLUDE)/%.h: libraries/%.h
	$(DIRECTORY_GUARD)
	cp $< $@

$(BUILD_DIRECTORY_INCLUDE)/%.h: libraries/libcompat/%.h
	$(DIRECTORY_GUARD)
	cp $< $@

-include libraries/*/.build.mk
$(foreach lib, $(LIBS), $(eval $(call LIB_TEMPLATE,$(lib))))