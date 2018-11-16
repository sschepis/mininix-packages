LINUXDROID_PKG_HOMEPAGE=http://www.cybercom.net/~dcoffin/dcraw/
LINUXDROID_PKG_DESCRIPTION="Raw digital camera images decoding utility"
LINUXDROID_PKG_VERSION=9.28.0
LINUXDROID_PKG_SHA256=2890c3da2642cd44c5f3bfed2c9b2c1db83da5cec09cc17e0fa72e17541fb4b9
LINUXDROID_PKG_SRCURL=http://www.cybercom.net/~dcoffin/dcraw/archive/dcraw-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="littlecms, libjasper, libjpeg-turbo"

linuxdroid_step_make_install () {
	# See the "install" script for flags:
	$CC $CFLAGS $CPPFLAGS $LDFLAGS dcraw.c $LINUXDROID_PKG_BUILDER_DIR/swab.c -lm -ljasper -ljpeg -llcms2 -o $LINUXDROID_PREFIX/bin/dcraw
        chmod +w dcraw.1 # Add missing write permission
	cp dcraw.1 $LINUXDROID_PREFIX/share/man/man1/
}
