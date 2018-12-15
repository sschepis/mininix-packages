MININIX_PKG_HOMEPAGE=https://github.com/martanne/dvtm
MININIX_PKG_DESCRIPTION="Terminal tiling window manager"
MININIX_PKG_VERSION=0.15
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://github.com/martanne/dvtm/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=496eada13d8abaa8d772279746f78b0c6fed11b560599490f3e70ebc21197bf0
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="libutil, ncurses"

mininix_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}
