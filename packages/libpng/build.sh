LINUXDROID_PKG_HOMEPAGE=http://www.libpng.org/pub/png/libpng.html
LINUXDROID_PKG_DESCRIPTION="Official PNG reference library"
LINUXDROID_PKG_VERSION=1.6.35
LINUXDROID_PKG_SHA256=23912ec8c9584917ed9b09c5023465d71709dce089be503c7867fec68a93bcd7
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/libpng-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/libpng-config bin/libpng16-config"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/png-fix-itxt bin/pngfix"
