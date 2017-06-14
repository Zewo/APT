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
# Purpose: Canned recipes for main makefile
#
# Author: Ronaldo F. Lima <ronaldo@nineteen.com.br>
#

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

define git-checkout
git clone --quiet $1 $3
git -C $3 checkout --quiet $2
endef

define splash
@echo "     ________"
@echo "    /\\_____  \\"
@echo "    \\/____//'/'     __   __  __  __    ___"
@echo "         //'/'    /'__\`\\/\\ \\/\\ \\/\\ \\  / __\`\\ "
@echo "        //'/'___ /\\  __/\\ \\ \\_/ \\_/ \\/\\ \\L\\ \\"
@echo "        /\\_______\\ \\____\\\\\\ \\___x___/'\\ \\____/"
@echo "        \\/_______/\\/____/ \\/__//__/   \\/___/ "
@echo "\n                 Packaging System\n\n"
endef
