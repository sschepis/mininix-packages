MININIX_PKG_HOMEPAGE=https://github.com/tgraf/bmon
MININIX_PKG_DESCRIPTION="Bandwidth monitor and rate estimator"
MININIX_PKG_VERSION=4.0
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://github.com/tgraf/bmon/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=d5e503ff6b116c681ebf4d10e238604dde836dceb9c0008eb92416a96c87ca40
MININIX_PKG_DEPENDS="libconfuse, libnl, ncurses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	./autogen.sh
}
