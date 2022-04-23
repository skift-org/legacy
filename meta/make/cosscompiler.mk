
build/sysroot/system/includes/%.h: userspace/libraries/%.h
	$(DIRECTORY_GUARD)
	cp $< $@

build/sysroot/system/includes/%.h: userspace/libraries/libc/%.h
	$(DIRECTORY_GUARD)
	cp $< $@

.PHONY: crosscompiler-headers
crosscompiler-headers: $(patsubst $(BUILD_DIRECTORY_INCLUDE)/%, build/sysroot/system/includes/%, $(HEADERS))
