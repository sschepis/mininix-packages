LINUXDROID_PKG_HOMEPAGE=http://www.sentex.net/~mwandel/jhead/
LINUXDROID_PKG_DESCRIPTION="Exif Jpeg header manipulation tool"
LINUXDROID_PKG_VERSION=3.00
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://www.sentex.net/~mwandel/jhead/jhead-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=88cc01da018e242fe2e05db73f91b6288106858dd70f27506c4989a575d2895e
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make_install () {
	cp jhead $LINUXDROID_PREFIX/bin/jhead
	cp -f jhead.1 $LINUXDROID_PREFIX/share/man/man1/jhead.1
}
