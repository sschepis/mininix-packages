LINUXDROID_PKG_HOMEPAGE=http://www.pixman.org/
LINUXDROID_PKG_DESCRIPTION="Low-level library for pixel manipulation"
LINUXDROID_PKG_VERSION=0.34.0
LINUXDROID_PKG_SRCURL=https://cairographics.org/releases/pixman-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=21b6b249b51c6800dc9553b65106e1e37d0e25df942c90531d4c3997aa20a88e
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-libpng"

linuxdroid_step_pre_configure () {
	if [ $LINUXDROID_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}
