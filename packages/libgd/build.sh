MININIX_PKG_HOMEPAGE=https://libgd.github.io/
MININIX_PKG_DESCRIPTION="GD is an open source code library for the dynamic creation of images by programmers"
MININIX_PKG_VERSION=2.2.5
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=a66111c9b4a04e818e9e2a37d7ae8d4aae0939a100a36b0ffb52c706a09074b5
MININIX_PKG_SRCURL=https://github.com/libgd/libgd/releases/download/gd-${MININIX_PKG_VERSION}/libgd-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="freetype, fontconfig, libjpeg-turbo, libpng, libtiff, libwebp"
# Disable vpx support for now, look at https://github.com/gagern/libgd/commit/d41eb72cd4545c394578332e5c102dee69e02ee8
# for enabling:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-vpx --without-x"
