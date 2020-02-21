EXECUTABLE_NAME = configcop
REPO = https://github.com/fivegoodfriends/ConfigCop
VERSION = 0.1.0

PREFIX = /usr/local
INSTALL_PATH = $(PREFIX)/bin/$(EXECUTABLE_NAME)
BUILD_PATH = .build/release/$(EXECUTABLE_NAME)
CURRENT_PATH = $(PWD)

.PHONY: install build uninstall

install: build
	mkdir -p $(PREFIX)/bin
	cp -f $(BUILD_PATH) $(INSTALL_PATH)

build:
	swift build --disable-sandbox -c release

uninstall:
	rm -f $(INSTALL_PATH)
