MININIX_PKG_HOMEPAGE=https://c-ares.haxx.se
MININIX_PKG_DESCRIPTION="Library for asynchronous DNS requests (including name resolves)"
MININIX_PKG_VERSION=1.15.0
MININIX_PKG_SHA256=7deb7872cbd876c29036d5f37e30c4cbc3cc068d59d8b749ef85bb0736649f04
MININIX_PKG_SRCURL=https://github.com/c-ares/c-ares/archive/cares-${MININIX_PKG_VERSION//./_}.tar.gz
# Build with cmake to install cmake/c-ares/*.cmake files:
MININIX_PKG_FORCE_CMAKE=yes
MININIX_PKG_RM_AFTER_INSTALL="bin/"
