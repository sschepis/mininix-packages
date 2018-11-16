LINUXDROID_PKG_HOMEPAGE=http://www.info-zip.org/
LINUXDROID_PKG_DESCRIPTION="Tools for working with zip files"
LINUXDROID_PKG_VERSION=3.0
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/infozip/zip30.tar.gz
LINUXDROID_PKG_SHA256=f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369
LINUXDROID_PKG_DEPENDS="libandroid-support, libbz2"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure () {
	cp unix/Makefile Makefile
}

linuxdroid_step_make () {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" make -j $LINUXDROID_MAKE_PROCESSES generic
}
