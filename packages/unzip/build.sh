LINUXDROID_PKG_HOMEPAGE=http://www.info-zip.org/
LINUXDROID_PKG_DESCRIPTION="Tools for working with zip files"
LINUXDROID_PKG_VERSION=6.0
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/infozip/unzip60.tar.gz
LINUXDROID_PKG_SHA256=036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37
LINUXDROID_PKG_DEPENDS="libandroid-support, libbz2"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure () {
	cp unix/Makefile Makefile
}

linuxdroid_step_make () {
	LD="$CC $LDFLAGS -lbz2" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS -DNO_LCHMOD -DUSE_BZIP2" make -j $LINUXDROID_MAKE_PROCESSES generic
}
