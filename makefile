
PREFIX=/usr/local
BUILD_DIR=$(PWD)/build

libdill.deb: $(BUILD_DIR)/libdill
	@echo "\nBUILDING $@..."

$(BUILD_DIR)/libdill: $(BUILD_DIR)
	@echo "\tDownloading libdill..."
	@echo "\tMK $@"
	-@mkdir $@
	@git clone -q https://github.com/Zewo/libdill.git $@
	@git -C $@ checkout -q 1.6
	@cd $@ && ./autogen.sh
	@$@/configure --srcdir=$@ --prefix=$(PREFIX)

$(BUILD_DIR): splash
	@echo "\tMK $@"
	-@mkdir $@

purge: splash
	@echo "PURGING..."
	@echo "\tRM $(BUILD_DIR)"
	@\rm -fR $(BUILD_DIR)

splash:
	@echo "     ________"
	@echo "    /\\_____  \\"
	@echo "    \\/____//'/'     __   __  __  __    ___"
	@echo "         //'/'    /'__\`\\/\\ \\/\\ \\/\\ \\  / __\`\\ "
	@echo "        //'/'___ /\\  __/\\ \\ \\_/ \\_/ \\/\\ \\L\\ \\"
	@echo "        /\\_______\\ \\____\\\\\\ \\___x___/'\\ \\____/"
	@echo "        \\/_______/\\/____/ \\/__//__/   \\/___/ "
	@echo "\n                 Packaging System\n\n"
