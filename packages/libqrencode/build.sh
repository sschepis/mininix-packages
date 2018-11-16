LINUXDROID_PKG_HOMEPAGE=https://fukuchi.org/works/qrencode/
LINUXDROID_PKG_DESCRIPTION="Libqrencode is a fast and compact library for encoding data in a QR Code symbol, a 2D symbology that can be scanned by handy terminals"
LINUXDROID_PKG_MAINTAINER="Henrik Grimler @Grimler91"
LINUXDROID_PKG_VERSION=4.0.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=43091fea4752101f0fe61a957310ead10a7cb4b81e170ce61e5baa73a6291ac2
LINUXDROID_PKG_SRCURL=https://github.com/fukuchi/libqrencode/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, libpng"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"
