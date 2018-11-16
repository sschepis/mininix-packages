LINUXDROID_PKG_HOMEPAGE=https://www.mars.org/home/rob/proj/hfs/
LINUXDROID_PKG_DESCRIPTION="Tool for manipulating HFS images."
LINUXDROID_PKG_VERSION=3.2.6
LINUXDROID_PKG_SRCURL=ftp://ftp.mars.org/pub/hfs/hfsutils-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=bc9d22d6d252b920ec9cdf18e00b7655a6189b3f34f42e58d5bb152957289840
LINUXDROID_PKG_DEPENDS="libandroid-support"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$LINUXDROID_PREFIX/share/man"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_configure() {
	mkdir -p ${LINUXDROID_PREFIX}/man/man1
}

