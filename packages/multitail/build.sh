MININIX_PKG_HOMEPAGE=http://www.vanheusden.com/multitail/
MININIX_PKG_DESCRIPTION="Tool to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge"
MININIX_PKG_VERSION=6.4.2
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://fossies.org/linux/privat/multitail-${MININIX_PKG_VERSION}.tgz
MININIX_PKG_SHA256=af1d5458a78ad3b747c5eeb135b19bdca281ce414cefdc6ea0cff6d913caa1fd
MININIX_PKG_DEPENDS="ncurses, ncurses-ui-libs, libandroid-glob"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	CFLAGS+=" -DNCURSES_WIDECHAR"
	LDFLAGS+=" -landroid-glob"
}
