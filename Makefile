all: submodules build

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
	rsync -av modules/node/ build/
	rsync -av modules/libsquash/ build/deps/libsquash/
	rsync -av overlay/deps/libsquash/ build/deps/libsquash/
	cd build \
		&& patch -p1 < ../patches/encloseio.patch \
		&& ./configure \
		&& make
