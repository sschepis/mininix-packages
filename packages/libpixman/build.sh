MININIX_PKG_HOMEPAGE=http://www.pixman.org/
MININIX_PKG_DESCRIPTION="Low-level library for pixel manipulation"
MININIX_PKG_VERSION=0.36.0
MININIX_PKG_SHA256=1ca19c8d4d37682adfbc42741d24977903fec1169b4153ec05bb690d4acf9fae
MININIX_PKG_SRCURL=https://cairographics.org/releases/pixman-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-libpng"

mininix_step_pre_configure () {
	if [ $MININIX_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}
