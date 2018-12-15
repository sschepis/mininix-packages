MININIX_PKG_HOMEPAGE=https://sourceware.org/libffi/
MININIX_PKG_DESCRIPTION="Library providing a portable, high level programming interface to various calling conventions"
local _COMMIT=716bfd83177689e2244c4707bd513003cff92c68
local _DATE=20171105
MININIX_PKG_VERSION=3.2.1.$_DATE
MININIX_PKG_SHA256=454577ab2d046dbdf5697f71598247fb8d8bf2d378817d5d5b8bc5dceaf822ac
MININIX_PKG_SRCURL=https://github.com/libffi/libffi/archive/${_COMMIT}.zip
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-multi-os-directory --enable-symvers=no"
MININIX_PKG_RM_AFTER_INSTALL="lib/libffi-${MININIX_PKG_VERSION}/include"

mininix_step_pre_configure () {
	cd $MININIX_PKG_SRCDIR
	./autogen.sh
}
