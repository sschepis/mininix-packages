MININIX_PKG_HOMEPAGE=https://fukuchi.org/works/qrencode/
MININIX_PKG_DESCRIPTION="Libqrencode is a fast and compact library for encoding data in a QR Code symbol, a 2D symbology that can be scanned by handy terminals"
MININIX_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MININIX_PKG_VERSION=4.0.2
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=43091fea4752101f0fe61a957310ead10a7cb4b81e170ce61e5baa73a6291ac2
MININIX_PKG_SRCURL=https://github.com/fukuchi/libqrencode/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, libpng"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"
