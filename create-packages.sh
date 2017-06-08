#!/bin/bash

# sudo apt-get install autoconf autogen libtool

DIR=${PWD}

# install libdill

PACKAGE=libdill
PACKAGE_VERSION=1.6.0

rm -rf ${PACKAGE}
git clone https://github.com/Zewo/${PACKAGE}
pushd ${PACKAGE}
./autogen.sh
./configure --prefix=${DIR}/${PACKAGE}-${PACKAGE_VERSION}
make
make install
popd
rm -rf ${PACKAGE}

INSTALL_PATH=${PACKAGE}/usr/local
INSTALL_INCLUDE_PATH=${INSTALL_PATH}/include
INSTALL_LIBRARY_PATH=${INSTALL_PATH}/lib

mkdir -p ${INSTALL_INCLUDE_PATH}
mkdir -p ${INSTALL_LIBRARY_PATH}
mv ${DIR}/${PACKAGE}-${PACKAGE_VERSION}/include ${INSTALL_PATH}
mv ${DIR}/${PACKAGE}-${PACKAGE_VERSION}/lib ${INSTALL_PATH}
rm -rf ${DIR}/${PACKAGE}-${PACKAGE_VERSION}/

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

rm -rf ${PACKAGE}
mkdir -p ${PACKAGE}
wget http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/${PACKAGE}-${PACKAGE_VERSION}.tar.gz
tar axf ${PACKAGE}-${PACKAGE_VERSION}.tar.gz -C ${DIR}/${PACKAGE} --strip-components=1
rm -rf ${PACKAGE}-${PACKAGE_VERSION}.tar.gz
pushd ${PACKAGE}
./configure --prefix=${DIR}/${PACKAGE}-${PACKAGE_VERSION}
make
make install
popd
rm -rf ${PACKAGE}

INSTALL_PATH=${PACKAGE}/usr/local/opt/libressl
INSTALL_INCLUDE_PATH=${INSTALL_PATH}/include
INSTALL_LIBRARY_PATH=${INSTALL_PATH}/lib

mkdir -p ${INSTALL_INCLUDE_PATH}
mkdir -p ${INSTALL_LIBRARY_PATH}
mv ${DIR}/${PACKAGE}-${PACKAGE_VERSION}/include ${INSTALL_PATH}
mv ${DIR}/${PACKAGE}-${PACKAGE_VERSION}/lib ${INSTALL_PATH}
rm -rf ${DIR}/${PACKAGE}-${PACKAGE_VERSION}/

INSTALL_PKGCONF_PATH=${PACKAGE}/usr/local/lib/pkgconfig

mkdir -p ${INSTALL_PKGCONF_PATH}
ln -s /usr/local/opt/libressl/lib/pkgconfig/libtls.pc ${INSTALL_PKGCONF_PATH}/libtls.pc

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

# create zewo deb

dpkg-deb --build zewo

# create Packages.gz

dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
