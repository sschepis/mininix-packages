LINUXDROID_PKG_HOMEPAGE=https://sourceware.org/libffi/
LINUXDROID_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
local _COMMIT=716bfd83177689e2244c4707bd513003cff92c68
local _DATE=20171105
LINUXDROID_PKG_VERSION=3.2.1.$_DATE
LINUXDROID_PKG_SHA256=454577ab2d046dbdf5697f71598247fb8d8bf2d378817d5d5b8bc5dceaf822ac
LINUXDROID_PKG_SRCURL=https://github.com/libffi/libffi/archive/${_COMMIT}.zip
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-multi-os-directory --enable-symvers=no"
LINUXDROID_PKG_RM_AFTER_INSTALL="lib/libffi-${LINUXDROID_PKG_VERSION}/include"

linuxdroid_step_pre_configure () {
	cd $LINUXDROID_PKG_SRCDIR
	./autogen.sh
}
