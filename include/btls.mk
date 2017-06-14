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
# Purpose: Definitions for BTLS build
#
# Author: Ronaldo F. Lima <ronaldo@nineteen.com.br>
#

BTLS_VERSION=0.1.0
BTLS_REPO=https://github.com/Zewo/btls.git
BTLS_MODULE=btls
BTLS_DESC="TLS sockets for libdill"
BTLS_PREFIX=/usr/local
BTLS_CFLAGS="-I$(BUILD_DIR)/install/libdill/usr/local/include -I$(BUILD_DIR)/install/libressl/usr/local/opt/libressl/include"
BTLS_INST_DIR=$(BUILD_DIR)/install/$(BTLS_MODULE)

$(BUILD_DIR)/$(BTLS_MODULE).deb: $(BTLS_INST_DIR)
	-@mkdir -p $</DEBIAN
	@$(call debian-control-file, $</DEBIAN/control, $(BTLS_MODULE), $(BTLS_VERSION), $(BTLS_DESC))
	@dpkg-deb --build $<
	@mv $</../$(BTLS_MODULE).deb $(PWD)

$(BUILD_DIR)/$(BTLS_MODULE): $(BUILD_DIR) 
	-@mkdir $@
	@$(call git-checkout, $(BTLS_REPO), $(BTLS_VERSION), $@)

$(BTLS_INST_DIR): $(BUILD_DIR)/$(BTLS_MODULE) $(DILL_INST_DIR) $(SSL_INST_DIR)
	+@$(MAKE) -C $(BUILD_DIR)/$(BTLS_MODULE)  install DESTDIR=$@ PREFIX=$(BTLS_PREFIX) CFLAGS=$(BTLS_CFLAGS)
