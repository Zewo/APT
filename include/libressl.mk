# -*-makefile-*-
# The MIT License (MIT)
#
# Copyright (c) 2017 Zewo
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Purpose: Definitions for libressl build and packaging
#
# Author: Ronaldo F. Lima <ronaldo@nineteen.com.br>
#

SSL_VERSION=2.5.4
SSL_PREFIX=/usr/local/opt/libressl
SSL_MODULE=libressl
SSL_OUT_DOC=$(SSL_MODULE)-$(SSL_VERSION).tar.gz
SSL_REPO=http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$(SSL_OUT_DOC)
SSL_LIB_DIR=$(SSL_PREFIX)/../../lib
SSL_INST_DIR=$(BUILD_DIR)/install/$(SSL_MODULE)
SSL_DESC="SSL crypto library"

$(BUILD_DIR)/$(SSL_MODULE).deb: $(SSL_INST_DIR)
	-@mkdir -p $</DEBIAN
	@$(call debian-control-file, $</DEBIAN/control, $(SSL_MODULE), $(SSL_VERSION), $(SSL_DESC))
	@dpkg-deb --build $<
	@mv $</../$(SSL_MODULE).deb $(PWD)

$(BUILD_DIR)/$(SSL_MODULE): $(BUILD_DIR)
	-@mkdir $@
	@wget $(SSL_REPO) --output-document $@/$(SSL_OUT_DOC)
	@tar xzf $@/$(SSL_OUT_DOC) -C $@ --strip-components=1

$(SSL_INST_DIR): $(BUILD_DIR)/$(SSL_MODULE)
	@cd $< && ./configure --quiet --prefix=$(SSL_PREFIX)
	+@$(MAKE) -C $< install DESTDIR=$(SSL_INST_DIR)
	-@mkdir -p $(SSL_INST_DIR)/$(SSL_LIB_DIR)/pkgconfig
	@cd $(SSL_INST_DIR)/$(SSL_LIB_DIR) && ln -s $(SSL_PREFIX)/lib/pkgconfig/libtls.pc pkgconfig/libtls.pc
