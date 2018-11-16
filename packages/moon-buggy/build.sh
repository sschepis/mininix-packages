LINUXDROID_PKG_HOMEPAGE=https://github.com/seehuhn/moon-buggy
LINUXDROID_PKG_DESCRIPTION="Simple game where you drive a car across the moon's surface"
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_VERSION=1.0.51
LINUXDROID_PKG_REVISION=1
# Main site down 2017-01-06.
# LINUXDROID_PKG_SRCURL=http://m.seehuhn.de/programs/moon-buggy-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SRCURL=ftp://ftp.netbsd.org/pub/pkgsrc/distfiles/moon-buggy-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=352dc16ccae4c66f1e87ab071e6a4ebeb94ff4e4f744ce1b12a769d02fe5d23f
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--sharedstatedir=$LINUXDROID_PREFIX/var"

linuxdroid_step_make_install () {
	mkdir -p $LINUXDROID_PREFIX/share/man/man6
	cp moon-buggy $LINUXDROID_PREFIX/bin
	cp moon-buggy.6 $LINUXDROID_PREFIX/share/man/man6
}
