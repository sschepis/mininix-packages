MININIX_PKG_HOMEPAGE=http://www.simplesystems.org/libtiff/ # Note that http://libtiff.org/ is hijacked
MININIX_PKG_DESCRIPTION="Support for the Tag Image File Format (TIFF) for storing image data"
MININIX_PKG_VERSION=4.0.10
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=2c52d11ccaf767457db0c46795d9c7d1a8d8f76f68b0b800a3dfe45786b996e4
MININIX_PKG_SRCURL=http://download.osgeo.org/libtiff/tiff-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libjpeg-turbo, liblzma"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-webp"
