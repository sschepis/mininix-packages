LINUXDROID_PKG_HOMEPAGE=http://www.nethack.org/
LINUXDROID_PKG_DESCRIPTION="Dungeon crawl game"
LINUXDROID_PKG_VERSION=3.6.0
LINUXDROID_PKG_SRCURL=https://s3.amazonaws.com/altorg/nethack/nethack-360-src.tgz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="ncurses"

linuxdroid_step_make_install () {
	cd $LINUXDROID_PKG_SRCDIR/sys/unix
	sh setup.sh hints/linux

	cd $LINUXDROID_PKG_SRCDIR
	make install
}
