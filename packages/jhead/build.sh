MININIX_PKG_HOMEPAGE=http://www.sentex.net/~mwandel/jhead/
MININIX_PKG_DESCRIPTION="Exif Jpeg header manipulation tool"
MININIX_PKG_VERSION=3.00
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=http://www.sentex.net/~mwandel/jhead/jhead-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=88cc01da018e242fe2e05db73f91b6288106858dd70f27506c4989a575d2895e
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make_install () {
	cp jhead $MININIX_PREFIX/bin/jhead
	cp -f jhead.1 $MININIX_PREFIX/share/man/man1/jhead.1
}
