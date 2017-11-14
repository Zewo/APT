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
# Purpose: Definitions for LIBDILL build and packaging
#
# Author: Ronaldo F. Lima <ronaldo@nineteen.com.br>
#

DILL_VERSION=1.6.2
DILL_REPO=https://github.com/Zewo/libdill.git
DILL_MODULE=libdill
DILL_DESC="Go-style C concurrency library"
DILL_INST_DIR=$(BUILD_DIR)/install/$(DILL_MODULE)
DILL_PREFIX=/usr/local

$(BUILD_DIR)/$(DILL_MODULE).deb: $(DILL_INST_DIR)
	-@mkdir -p $</DEBIAN
	-@$(call debian-control-file, $</DEBIAN/control, $(DILL_MODULE), $(DILL_VERSION), $(DILL_DESC))
	@dpkg-deb --build $<
	@mv $</../$(DILL_MODULE).deb $(PWD)

$(BUILD_DIR)/$(DILL_MODULE): $(BUILD_DIR)
	-@mkdir $@
	-@$(call git-checkout, $(DILL_REPO), $(DILL_VERSION), $@)

$(DILL_INST_DIR): $(BUILD_DIR)/$(DILL_MODULE)
	@cd $< && ./autogen.sh 2>&1 > /dev/null
	@cd $< && ./configure --quiet --prefix=$(DILL_PREFIX)
	+@$(MAKE) -C $< install DESTDIR=$(DILL_INST_DIR)
