LINUXDROID_PKG_HOMEPAGE=https://sourceware.org/libffi/
LINUXDROID_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
LINUXDROID_PKG_VERSION=3.2.1
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=ftp://sourceware.org/pub/libffi/libffi-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=d06ebb8e1d9a22d19e38d63fdb83954253f39bedc5d46232a05645685722ca37
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-multi-os-directory"
LINUXDROID_PKG_RM_AFTER_INSTALL="lib/libffi-${LINUXDROID_PKG_VERSION}/include"

linuxdroid_step_pre_configure () {
	if [ $LINUXDROID_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}
