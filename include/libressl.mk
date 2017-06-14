SSL_VERSION=2.5.4
SSL_PREFIX=/usr/local/opt/libressl
SSL_MODULE=libressl
SSL_OUT_DOC=$(SSL_MODULE)-$(SSL_VERSION).tar.gz
SSL_REPO=http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$(SSL_OUT_DOC)
SSL_LIB_DIR=$(SSL_PREFIX)/../../lib
SSL_INST_DIR=$(DESTDIR)/$(SSL_MODULE)
SSL_DESC="SSL crypto library"

$(DESTDIR)/$(SSL_MODULE).deb: $(BUILD_DIR)/$(SSL_MODULE)
	-@mkdir -p $</DEBIAN
	@$(call debian-control-file, $</DEBIAN/control, $(SSL_MODULE), $(SSL_VERSION), $(SSL_DESC))
	@dpkg-deb --build $<

$(BUILD_DIR)/$(SSL_MODULE): $(BUILD_DIR)
	-@mkdir $@
	@wget $(SSL_REPO) --output-document $@/$(SSL_OUT_DOC)
	@tar xzf $@/$(SSL_OUT_DOC) -C $@ --strip-components=1
	@cd $@ && ./configure --quiet --prefix=$(SSL_PREFIX)
	@make -C $@ -j 8
	@make -C $@ -j 8 install DESTDIR=$(SSL_INST_DIR)
	-@mkdir -p $(SSL_INST_DIR)/$(SSL_LIB_DIR)/pkgconfig
	@cd $(SSL_INST_DIR)/$(SSL_LIB_DIR) && ln -s ../../opt/libressl/lib/pkgconfig/libtls.pc pkgconfig/libtls.pc
