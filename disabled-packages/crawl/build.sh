# Currently fails at:
# Makefile:101: recipe for target 'tiledef-dngn.h' failed
# make[1]: *** [tiledef-dngn.h] Segmentation fault (core dumped)

MININIX_PKG_HOMEPAGE=https://crawl.develz.org/
MININIX_PKG_DESCRIPTION="Roguelike adventure through dungeons filled with dangerous monsters"
MININIX_PKG_VERSION=0.17.1
MININIX_PKG_SRCURL=https://crawl.develz.org/release/stone_soup-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_EXTRA_MAKE_ARGS="V=1"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	export CROSSHOST=$MININIX_HOST_PLATFORM
	MININIX_PKG_BUILDDIR=$MININIX_PKG_SRCDIR/source
}
