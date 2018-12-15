MININIX_PKG_HOMEPAGE=http://www.canonware.com/jemalloc/
MININIX_PKG_DESCRIPTION="General-purpose scalable concurrent malloc(3) implementation"
MININIX_PKG_VERSION=4.0.0
MININIX_PKG_SRCURL=https://github.com/jemalloc/jemalloc/releases/download/${MININIX_PKG_VERSION}/jemalloc-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_BUILD_IN_SRC="yes"

CPPFLAGS+=" -D__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4=1"
