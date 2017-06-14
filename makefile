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
# Purpose: Builds Debian packages with system libraries required by Zewo
# run-time
#
# Author: Ronaldo F. Lima <ronaldo@nineteen.com.br>
#

BUILD_DIR=$(PWD)/build
PACKAGES=libdill.deb libressl.deb btls.deb
DEB_PACKAGES=$(PACKAGES:%.deb=$(BUILD_DIR)/%.deb)
LOCAL_REPOS=$(DEB_PACKAGES:%.deb=%)

include include/functions.mk
include include/libdill.mk
include include/libressl.mk
include include/btls.mk

.PHONY: all clean purge splash

splash:
	$(splash)

all: splash $(PACKAGES)
	@dpkg-deb --build zewo
	@dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz

$(PACKAGES):$(DEB_PACKAGES)

$(DEB_PACKAGES): $(LOCAL_REPOS)

$(LOCAL_REPOS): $(BUILD_DIR)

$(BUILD_DIR): 
	-@mkdir $@

clean: splash
	@\rm -fR $(BUILD_DIR)

purge: clean
	@\rm -f $(PACKAGES) zewo.deb Packages.gz
