LINUXDROID_PKG_HOMEPAGE=http://www.clifford.at/stfl
LINUXDROID_PKG_DESCRIPTION="Structured Terminal Forms Language/Library"
LINUXDROID_PKG_VERSION=0.24
LINUXDROID_PKG_SRCURL=http://www.clifford.at/stfl/stfl-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=d4a7aa181a475aaf8a8914a8ccb2a7ff28919d4c8c0f8a061e17a0c36869c090
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure() {
	export CC="$CC $CPPFLAGS"
	export CFLAGS="-I. -fPIC -Wall -Os -ggdb"
	export LDFLAGS="-L${LINUXDROID_PREFIX}/lib -lncursesw -liconv"
}
