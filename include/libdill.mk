DILL_VERSION=1.6
DILL_REPO=https://github.com/Zewo/libdill.git
DILL_MODULE=libdill
DILL_DESC="Go-style C concurrency library"

$(DESTDIR)/$(DILL_MODULE).deb: $(BUILD_DIR)/$(DILL_MODULE)
	-@mkdir -p $</DEBIAN
	@$(call debian-control-file, $</DEBIAN/control, $(DILL_MODULE), $(DILL_VERSION), $(DILL_DESC))
	@dpkg-deb --build $<

$(BUILD_DIR)/$(DILL_MODULE): $(BUILD_DIR)
	-@mkdir $@
	@$(call git-checkout, $(DILL_REPO), $(DILL_VERSION), $@)
	@cd $@ && ./autogen.sh 2>&1 > /dev/null
	@cd $@ && ./configure --quiet --prefix=$(PREFIX)
	@make -C $@ -j 8
	@make -C $@ -j 8 install DESTDIR=$(DESTDIR)/$(DILL_MODULE)
