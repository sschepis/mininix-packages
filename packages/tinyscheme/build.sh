MININIX_PKG_HOMEPAGE=http://tinyscheme.sourceforge.net/home.html
MININIX_PKG_DESCRIPTION="Very small scheme implementation"
MININIX_PKG_VERSION=1.41
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/tinyscheme/tinyscheme/tinyscheme-1.41/tinyscheme-1.41.tar.gz
MININIX_PKG_SHA256=eac0103494c755192b9e8f10454d9f98f2bbd4d352e046f7b253439a3f991999
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	AR+=" crs"
	LD=$CC
}

mininix_step_post_make_install () {
	mkdir -p $MININIX_PREFIX/share/tinyscheme/
	cp $MININIX_PKG_SRCDIR/init.scm $MININIX_PREFIX/share/tinyscheme/
}
