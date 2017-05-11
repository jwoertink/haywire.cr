PREFIX ?= /usr/local

.PHONY: dependencies
dependencies:
	git clone https://github.com/haywire/haywire.git lib/haywire
	cd lib/haywire
	./make.sh
	cp build/Debug/libhaywire.a $(PREFIX)/lib

