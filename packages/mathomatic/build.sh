MININIX_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Mathomatic
MININIX_PKG_DESCRIPTION="Simple CAS and symbolic calculator"
MININIX_PKG_VERSION=16.0.5
MININIX_PKG_REVISION=3
MININIX_PKG_SRCURL="https://fossies.org/linux/misc/old/mathomatic-${MININIX_PKG_VERSION}.tar.xz"
MININIX_PKG_SHA256=7f525bdb2e13006549dd8f17906c26f926f5ac51174f02f074107c612491e05c
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_MAKE_ARGS="READLINE=1"
MININIX_PKG_DEPENDS="readline"
MININIX_PKG_RM_AFTER_INSTALL="share/applications/mathomatic.desktop share/pixmaps"
MININIX_PKG_MAINTAINER="Jonathan Badger @jhbadger"

mininix_step_pre_configure() {
	rm $MININIX_PKG_SRCDIR/CMakeLists.txt
	CPPFLAGS+=" -DUSE_TGAMMA -DBOLD_COLOR"
}
