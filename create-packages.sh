#!/bin/bash

# sudo apt-get install autoconf autogen libtool

DIR=${PWD}

# install libdill

PACKAGE=libdill
PACKAGE_VERSION=1.6.0
PREFIX=/usr/local
DESTDIR=${DIR}/${PACKAGE}
MAKEDIR=${PACKAGE}-${PACKAGE_VERSION}

rm -rf ${DESTDIR}

git clone https://github.com/Zewo/${PACKAGE} ${MAKEDIR}
pushd ${MAKEDIR}
./autogen.sh
./configure --prefix=${PREFIX}
make
make install DESTDIR=${DESTDIR}
popd
rm -rf ${MAKEDIR}

# create libdill deb

rm -f ${PACKAGE}.deb
mkdir -p ${PACKAGE}/DEBIAN
CONTROL=${PACKAGE}/DEBIAN/control
rm -f ${CONTROL}
touch ${CONTROL}
echo "Package: ${PACKAGE}" >> ${CONTROL}
echo "Version: ${PACKAGE_VERSION}" >> ${CONTROL}
echo "Section: custom" >> ${CONTROL}
echo "Priority: optional" >> ${CONTROL}
echo "Architecture: all" >> ${CONTROL}
echo "Essential: no" >> ${CONTROL}
echo "Installed-Size: 256" >> ${CONTROL}
echo "Maintainer: zewo.io" >> ${CONTROL}
echo "Description: ${PACKAGE}" >> ${CONTROL}
dpkg-deb --build ${PACKAGE}

# install libressl

PACKAGE=libressl
PACKAGE_VERSION=2.5.4
PREFIX=/usr/local/opt/libressl
DESTDIR=${DIR}/${PACKAGE}
MAKEDIR=${PACKAGE}-${PACKAGE_VERSION}

rm -rf ${DESTDIR}

mkdir -p ${MAKEDIR}
wget http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${MAKEDIR}.tar.gz
tar axf ${MAKEDIR}.tar.gz -C ${MAKEDIR} --strip-components=1
rm -rf ${MAKEDIR}.tar.gz
pushd ${MAKEDIR}
./configure --prefix=${PREFIX}
make
make install DESTDIR=${DESTDIR}
popd
rm -rf ${MAKEDIR}

INSTALL_PKGCONF_PATH=${DESTDIR}/usr/local/lib/pkgconfig

mkdir -p ${INSTALL_PKGCONF_PATH}
ln -s ${PREFIX}/lib/pkgconfig/libtls.pc ${INSTALL_PKGCONF_PATH}/libtls.pc

# create libressl deb

rm -f ${PACKAGE}.deb
mkdir -p ${PACKAGE}/DEBIAN
CONTROL=${PACKAGE}/DEBIAN/control
rm -f ${CONTROL}
touch ${CONTROL}
echo "Package: ${PACKAGE}" >> ${CONTROL}
echo "Version: ${PACKAGE_VERSION}" >> ${CONTROL}
echo "Section: custom" >> ${CONTROL}
echo "Priority: optional" >> ${CONTROL}
echo "Architecture: all" >> ${CONTROL}
echo "Essential: no" >> ${CONTROL}
echo "Installed-Size: 256" >> ${CONTROL}
echo "Maintainer: zewo.io" >> ${CONTROL}
echo "Description: ${PACKAGE}" >> ${CONTROL}
dpkg-deb --build ${PACKAGE}

# install btls

PACKAGE=btls
PACKAGE_VERSION=0.1.0
PREFIX=/usr/local
DESTDIR=${DIR}/${PACKAGE}
MAKEDIR=${PACKAGE}-${PACKAGE_VERSION}

rm -rf ${DESTDIR}

git clone https://github.com/Zewo/${PACKAGE} ${MAKEDIR}
pushd ${MAKEDIR}
make install DESTDIR=${DESTDIR} PREFIX=${PREFIX}
popd
rm -rf ${MAKEDIR}

# create libdill deb

rm -f ${PACKAGE}.deb
mkdir -p ${PACKAGE}/DEBIAN
CONTROL=${PACKAGE}/DEBIAN/control
rm -f ${CONTROL}
touch ${CONTROL}
echo "Package: ${PACKAGE}" >> ${CONTROL}
echo "Version: ${PACKAGE_VERSION}" >> ${CONTROL}
echo "Section: custom" >> ${CONTROL}
echo "Priority: optional" >> ${CONTROL}
echo "Architecture: all" >> ${CONTROL}
echo "Essential: no" >> ${CONTROL}
echo "Installed-Size: 256" >> ${CONTROL}
echo "Maintainer: zewo.io" >> ${CONTROL}
echo "Description: ${PACKAGE}" >> ${CONTROL}
echo "Depends: libdill, libressl" >> ${CONTROL}
dpkg-deb --build ${PACKAGE}

# create zewo deb

dpkg-deb --build zewo

# create Packages.gz

dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
