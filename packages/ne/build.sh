MININIX_PKG_HOMEPAGE=http://ne.di.unimi.it/
MININIX_PKG_DESCRIPTION="Easy-to-use and powerful text editor"
MININIX_PKG_MAINTAINER="David Martínez @vaites"
MININIX_PKG_VERSION=3.1.2
MININIX_PKG_SHA256=31710ce07d6134355f311b249dcd0a8c99c0075b377bbb78a99ee1338d00c6a3
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/ne-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="libandroid-support, ncurses"
MININIX_PKG_RM_AFTER_INSTALL="info/"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	export OPTS="$CFLAGS $CPPFLAGS"
}
