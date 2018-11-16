LINUXDROID_PKG_HOMEPAGE=https://github.com/mtoyoda/sl
LINUXDROID_PKG_DESCRIPTION="Tool curing your bad habit of mistyping"
LINUXDROID_PKG_VERSION=5.02
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://github.com/mtoyoda/sl/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make_install () {
	install sl $LINUXDROID_PREFIX/bin/
	cp sl.1 $LINUXDROID_PREFIX/share/man/man1
}
