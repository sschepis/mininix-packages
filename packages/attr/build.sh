LINUXDROID_PKG_HOMEPAGE=http://savannah.nongnu.org/projects/attr/
LINUXDROID_PKG_DESCRIPTION="Utilities for manipulating filesystem extended attributes"
LINUXDROID_PKG_VERSION=2.4.48
LINUXDROID_PKG_SRCURL=http://download.savannah.gnu.org/releases/attr/attr-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=5ead72b358ec709ed00bbf7a9eaef1654baad937c001c044fe8b74c57f5324e7
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--enable-gettext=no"
# LINUXDROID_PKG_MAKE_INSTALL_TARGET="install install-lib"
# attr.5 man page is in linux-man-pages:
LINUXDROID_PKG_RM_AFTER_INSTALL="share/man/man5/attr.5"
