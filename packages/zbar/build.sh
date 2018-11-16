LINUXDROID_PKG_HOMEPAGE=http://zbar.sourceforge.net
LINUXDROID_PKG_DESCRIPTION="Software suite for reading bar codes from various sources"
LINUXDROID_PKG_VERSION=0.10
LINUXDROID_PKG_REVISION=6
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/zbar/zbar/0.10/zbar-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=234efb39dbbe5cef4189cc76f37afbe3cfcfb45ae52493bfe8e191318bdbadc6
LINUXDROID_PKG_DEPENDS="imagemagick, libjpeg-turbo"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-pthread
--disable-video --without-xshm --without-xv
--without-x --without-gtk --without-qt
--without-python --mandir=$LINUXDROID_PREFIX/share/man"

linuxdroid_step_pre_configure () {
	autoconf
}
