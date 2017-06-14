BTLS_VERSION=0.1.0
BTLS_REPO=https://github.com/Zewo/btls.git
BTLS_MODULE=btls
BTLS_DESC="Go-style C concurrency library"
BTLS_PREFIX=/usr/local
BTLS_CFLAGS="-I$(BUILD_DIR)/install/libdill/usr/local/include -I$(BUILD_DIR)/install/libressl/usr/local/opt/libressl/include"
$(DESTDIR)/$(BTLS_MODULE).deb: $(BUILD_DIR)/$(BTLS_MODULE)
	-@mkdir -p $</DEBIAN
	@$(call debian-control-file, $</DEBIAN/control, $(BTLS_MODULE), $(BTLS_VERSION), $(BTLS_DESC))
	@dpkg-deb --build $<

$(BUILD_DIR)/$(BTLS_MODULE): $(BUILD_DIR) $(BUILD_DIR)/$(DILL_MODULE) $(BUILD_DIR)/$(SSL_MODULE)
	-@mkdir $@
	@$(call git-checkout, $(BTLS_REPO), $(BTLS_VERSION), $@)
	@make -C $@ -j 8 install DESTDIR=$(DESTDIR)/$(BTLS_MODULE) PREFIX=$(BTLS_PREFIX) CFLAGS=$(BTLS_CFLAGS)
