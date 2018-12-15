MININIX_PKG_HOMEPAGE=https://cmake.org/
MININIX_PKG_DESCRIPTION="Family of tools designed to build, test and package software"
MININIX_PKG_VERSION=3.13.1
MININIX_PKG_SHA256=befe1ce6d672f2881350e94d4e3cc809697dd2c09e5b708b76c1dae74e1b2210
MININIX_PKG_SRCURL=https://www.cmake.org/files/v${MININIX_PKG_VERSION:0:4}/cmake-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libarchive, libcurl, libexpat, jsoncpp, libuv, rhash, make, clang"
MININIX_PKG_FORCE_CMAKE=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="-DKWSYS_LFS_WORKS=ON -DBUILD_CursesDialog=ON"
