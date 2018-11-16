LINUXDROID_PKG_HOMEPAGE=https://c-ares.haxx.se
LINUXDROID_PKG_DESCRIPTION="Library for asynchronous DNS requests (including name resolves)"
LINUXDROID_PKG_VERSION=1.15.0
LINUXDROID_PKG_SHA256=7deb7872cbd876c29036d5f37e30c4cbc3cc068d59d8b749ef85bb0736649f04
LINUXDROID_PKG_SRCURL=https://github.com/c-ares/c-ares/archive/cares-${LINUXDROID_PKG_VERSION//./_}.tar.gz
# Build with cmake to install cmake/c-ares/*.cmake files:
LINUXDROID_PKG_FORCE_CMAKE=yes
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/"
