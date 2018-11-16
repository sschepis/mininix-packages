LINUXDROID_PKG_HOMEPAGE=http://tinyscheme.sourceforge.net/home.html
LINUXDROID_PKG_DESCRIPTION="Very small scheme implementation"
LINUXDROID_PKG_VERSION=1.41
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/tinyscheme/tinyscheme/tinyscheme-1.41/tinyscheme-1.41.tar.gz
LINUXDROID_PKG_SHA256=eac0103494c755192b9e8f10454d9f98f2bbd4d352e046f7b253439a3f991999
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	AR+=" crs"
	LD=$CC
}

linuxdroid_step_post_make_install () {
	mkdir -p $LINUXDROID_PREFIX/share/tinyscheme/
	cp $LINUXDROID_PKG_SRCDIR/init.scm $LINUXDROID_PREFIX/share/tinyscheme/
}
