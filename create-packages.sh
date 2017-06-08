#!/bin/bash

# sudo apt-get install autoconf autogen libtool

DIR=${PWD}

# install libdill

LIBDILL_VERSION=1.6.0

rm -rf libdill
git clone https://github.com/Zewo/libdill
pushd libdill
./autogen.sh
./configure --prefix=${DIR}/libdill-${LIBDILL_VERSION}
make
make install
popd
rm -rf libdill
mv ${DIR}/libdill-${LIBDILL_VERSION} ${DIR}/libdill

# create libdill deb

PACKAGE=libdill
rm -f ${PACKAGE}.deb
mkdir -p ${PACKAGE}/DEBIAN
CONTROL=${PACKAGE}/DEBIAN/control
rm -f ${CONTROL}
touch ${CONTROL}
echo "Package: ${PACKAGE}" >> ${CONTROL}
echo "Version: ${LIBDILL_VERSION}" >> ${CONTROL}
echo "Section: custom" >> ${CONTROL}
echo "Priority: optional" >> ${CONTROL}
echo "Architecture: all" >> ${CONTROL}
echo "Essential: no" >> ${CONTROL}
echo "Installed-Size: 16224" >> ${CONTROL}
echo "Maintainer: zewo.io" >> ${CONTROL}
echo "Description: ${PACKAGE}" >> ${CONTROL}
dpkg-deb --build ${PACKAGE}

# create zewo deb

dpkg-deb --build zewo

# create Packages.gz

dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
