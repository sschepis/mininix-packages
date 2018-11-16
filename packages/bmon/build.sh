LINUXDROID_PKG_HOMEPAGE=https://github.com/tgraf/bmon
LINUXDROID_PKG_DESCRIPTION="Bandwidth monitor and rate estimator"
LINUXDROID_PKG_VERSION=4.0
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://github.com/tgraf/bmon/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_SHA256=d5e503ff6b116c681ebf4d10e238604dde836dceb9c0008eb92416a96c87ca40
LINUXDROID_PKG_DEPENDS="libconfuse, libnl, ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	./autogen.sh
}
