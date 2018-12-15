MININIX_PKG_HOMEPAGE=https://github.com/seehuhn/moon-buggy
MININIX_PKG_DESCRIPTION="Simple game where you drive a car across the moon's surface"
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_VERSION=1.0.51
MININIX_PKG_REVISION=1
# Main site down 2017-01-06.
# MININIX_PKG_SRCURL=http://m.seehuhn.de/programs/moon-buggy-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SRCURL=ftp://ftp.netbsd.org/pub/pkgsrc/distfiles/moon-buggy-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=352dc16ccae4c66f1e87ab071e6a4ebeb94ff4e4f744ce1b12a769d02fe5d23f
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--sharedstatedir=$MININIX_PREFIX/var"

mininix_step_make_install () {
	mkdir -p $MININIX_PREFIX/share/man/man6
	cp moon-buggy $MININIX_PREFIX/bin
	cp moon-buggy.6 $MININIX_PREFIX/share/man/man6
}
