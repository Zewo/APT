PREFIX=/usr/local
BUILD_DIR=$(PWD)/build
DESTDIR=$(BUILD_DIR)/install
PACKAGES=libdill.deb libressl.deb
TARGETS=$(PACKAGES:%.deb=$(DESTDIR)/%.deb)

include include/functions.mk
include include/libdill.mk
include include/libressl.mk

all: $(TARGETS)
	echo $(TARGETS)

$(BUILD_DIR): splash
	-@mkdir $@

purge: splash
	@\rm -fR $(BUILD_DIR)
	@\rm -fR $(DESTDIR)

splash:
	@echo "     ________"
	@echo "    /\\_____  \\"
	@echo "    \\/____//'/'     __   __  __  __    ___"
	@echo "         //'/'    /'__\`\\/\\ \\/\\ \\/\\ \\  / __\`\\ "
	@echo "        //'/'___ /\\  __/\\ \\ \\_/ \\_/ \\/\\ \\L\\ \\"
	@echo "        /\\_______\\ \\____\\\\\\ \\___x___/'\\ \\____/"
	@echo "        \\/_______/\\/____/ \\/__//__/   \\/___/ "
	@echo "\n                 Packaging System\n\n"
