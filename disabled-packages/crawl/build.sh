# Currently fails at:
# Makefile:101: recipe for target 'tiledef-dngn.h' failed
# make[1]: *** [tiledef-dngn.h] Segmentation fault (core dumped)

LINUXDROID_PKG_HOMEPAGE=https://crawl.develz.org/
LINUXDROID_PKG_DESCRIPTION="Roguelike adventure through dungeons filled with dangerous monsters"
LINUXDROID_PKG_VERSION=0.17.1
LINUXDROID_PKG_SRCURL=https://crawl.develz.org/release/stone_soup-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_EXTRA_MAKE_ARGS="V=1"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	export CROSSHOST=$LINUXDROID_HOST_PLATFORM
	LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_SRCDIR/source
}
