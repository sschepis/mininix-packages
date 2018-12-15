MININIX_PKG_HOMEPAGE=https://github.com/mtoyoda/sl
MININIX_PKG_DESCRIPTION="Tool curing your bad habit of mistyping"
MININIX_PKG_VERSION=5.02
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://github.com/mtoyoda/sl/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make_install () {
	install sl $MININIX_PREFIX/bin/
	cp sl.1 $MININIX_PREFIX/share/man/man1
}
