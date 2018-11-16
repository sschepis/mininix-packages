LINUXDROID_PKG_HOMEPAGE=http://www.canonware.com/jemalloc/
LINUXDROID_PKG_DESCRIPTION="General-purpose scalable concurrent malloc(3) implementation"
LINUXDROID_PKG_VERSION=4.0.0
LINUXDROID_PKG_SRCURL=https://github.com/jemalloc/jemalloc/releases/download/${LINUXDROID_PKG_VERSION}/jemalloc-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_BUILD_IN_SRC="yes"

CPPFLAGS+=" -D__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4=1"
