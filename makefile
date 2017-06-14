
PREFIX=/usr/local
BUILD_DIR=$(PWD)/build
DESTDIR=$(BUILD_DIR)/install

define debian-control-file
echo "Package: $2"         >  $1
echo "Version: $3"         >> $1
echo "Section: custom"     >> $1
echo "Priority: optional"  >> $1
echo "Architecture: all"   >> $1
echo "Essential: no"       >> $1
echo "Installed-Size: 256" >> $1
echo "Maintainer: zewo.io" >> $1
echo "Description: $4"     >> $1
endef

libdill.deb: $(BUILD_DIR)/libdill
	-@mkdir -p $(DESTDIR)/libdill/DEBIAN
	@$(call debian-control-file, $(DESTDIR)/libdill/DEBIAN/control, libdill, 1.6, libdill)
	@cd $< && dkpg-deb --build $@

$(BUILD_DIR)/libdill: $(BUILD_DIR)
	-@mkdir $@
	@git clone -q https://github.com/Zewo/libdill.git $@
	@git -C $@ checkout -q 1.6
	@cd $@ && ./autogen.sh
	@cd $@ && ./configure --prefix=$(PREFIX)
	@make -C $@ -j 8
	@make -C $@ -j 8 install DESTDIR=$(DESTDIR)/libdill 

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
