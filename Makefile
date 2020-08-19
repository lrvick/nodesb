.PHONY: submodules
submodules:
	if git submodule status | egrep -q '^[-]|^[+]'; then \
		echo "INFO: Need to reinitialize git submodules"; \
		git submodule update --init; \
	fi

.PHONY: clean
clean:
	rm -rf build

build: submodules
	cp -R modules/node/ build/
	cp -R modules/libsquash build/deps/libsquash
	cp -R modules/libautoupdate build/deps/libautoupdate
	cd build && patch -p1 < ../patches/encloseio.patch
