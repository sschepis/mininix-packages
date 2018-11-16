LINUXDROID_PKG_HOMEPAGE=https://sites.google.com/site/broguegame/
LINUXDROID_PKG_DESCRIPTION="Roguelike dungeon crawling game"
LINUXDROID_PKG_VERSION=1.7.5
LINUXDROID_PKG_SHA256=a74ff18139564c597d047cfb167f74ab1963dd8608b6fb2e034e7635d6170444
LINUXDROID_PKG_SRCURL=https://sites.google.com/site/broguegame/brogue-${LINUXDROID_PKG_VERSION}-linux-amd64.tbz2
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_EXTRA_MAKE_ARGS="curses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS"
}

linuxdroid_step_make_install () {
	cp bin/brogue $LINUXDROID_PREFIX/bin
}
