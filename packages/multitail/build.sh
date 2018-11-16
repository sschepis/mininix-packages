LINUXDROID_PKG_HOMEPAGE=http://www.vanheusden.com/multitail/
LINUXDROID_PKG_DESCRIPTION="Tool to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge"
LINUXDROID_PKG_VERSION=6.4.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/privat/multitail-${LINUXDROID_PKG_VERSION}.tgz
LINUXDROID_PKG_SHA256=af1d5458a78ad3b747c5eeb135b19bdca281ce414cefdc6ea0cff6d913caa1fd
LINUXDROID_PKG_DEPENDS="ncurses, ncurses-ui-libs, libandroid-glob"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	CFLAGS+=" -DNCURSES_WIDECHAR"
	LDFLAGS+=" -landroid-glob"
}
