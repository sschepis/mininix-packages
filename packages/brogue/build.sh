MININIX_PKG_HOMEPAGE=https://sites.google.com/site/broguegame/
MININIX_PKG_DESCRIPTION="Roguelike dungeon crawling game"
MININIX_PKG_VERSION=1.7.5
MININIX_PKG_SHA256=a74ff18139564c597d047cfb167f74ab1963dd8608b6fb2e034e7635d6170444
MININIX_PKG_SRCURL=https://sites.google.com/site/broguegame/brogue-${MININIX_PKG_VERSION}-linux-amd64.tbz2
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_EXTRA_MAKE_ARGS="curses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS"
}

mininix_step_make_install () {
	cp bin/brogue $MININIX_PREFIX/bin
}
