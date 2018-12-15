MININIX_PKG_HOMEPAGE=http://savannah.nongnu.org/projects/attr/
MININIX_PKG_DESCRIPTION="Utilities for manipulating filesystem extended attributes"
MININIX_PKG_VERSION=2.4.48
MININIX_PKG_SRCURL=http://download.savannah.gnu.org/releases/attr/attr-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--enable-gettext=no"
# MININIX_PKG_MAKE_INSTALL_TARGET="install install-lib"
# attr.5 man page is in linux-man-pages:
MININIX_PKG_RM_AFTER_INSTALL="share/man/man5/attr.5"
