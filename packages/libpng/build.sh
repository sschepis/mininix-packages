MININIX_PKG_HOMEPAGE=http://www.libpng.org/pub/png/libpng.html
MININIX_PKG_DESCRIPTION="Official PNG reference library"
MININIX_PKG_VERSION=1.6.35
MININIX_PKG_SHA256=23912ec8c9584917ed9b09c5023465d71709dce089be503c7867fec68a93bcd7
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/libpng-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/libpng-config bin/libpng16-config"
MININIX_PKG_RM_AFTER_INSTALL="bin/png-fix-itxt bin/pngfix"
