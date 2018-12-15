MININIX_PKG_HOMEPAGE=http://www.nethack.org/
MININIX_PKG_DESCRIPTION="Dungeon crawl game"
MININIX_PKG_VERSION=3.6.0
MININIX_PKG_SRCURL=https://s3.amazonaws.com/altorg/nethack/nethack-360-src.tgz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="ncurses"

mininix_step_make_install () {
	cd $MININIX_PKG_SRCDIR/sys/unix
	sh setup.sh hints/linux

	cd $MININIX_PKG_SRCDIR
	make install
}
