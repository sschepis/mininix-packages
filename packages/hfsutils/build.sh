MININIX_PKG_HOMEPAGE=https://www.mars.org/home/rob/proj/hfs/
MININIX_PKG_DESCRIPTION="Tool for manipulating HFS images."
MININIX_PKG_VERSION=3.2.6
MININIX_PKG_SRCURL=ftp://ftp.mars.org/pub/hfs/hfsutils-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=bc9d22d6d252b920ec9cdf18e00b7655a6189b3f34f42e58d5bb152957289840
MININIX_PKG_DEPENDS="libandroid-support"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MININIX_PREFIX/share/man"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_configure() {
	mkdir -p ${MININIX_PREFIX}/man/man1
}

