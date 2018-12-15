MININIX_PKG_HOMEPAGE=https://sourceware.org/libffi/
MININIX_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
MININIX_PKG_VERSION=3.2.1
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=ftp://sourceware.org/pub/libffi/libffi-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=d06ebb8e1d9a22d19e38d63fdb83954253f39bedc5d46232a05645685722ca37
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-multi-os-directory"
MININIX_PKG_RM_AFTER_INSTALL="lib/libffi-${MININIX_PKG_VERSION}/include"

mininix_step_pre_configure () {
	if [ $MININIX_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi
}
