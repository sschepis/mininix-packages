LINUXDROID_PKG_HOMEPAGE=http://www.tads.org/frobtads.htm
LINUXDROID_PKG_DESCRIPTION="TADS is a free authoring system for writing your own Interactive Fiction"
LINUXDROID_PKG_VERSION=1.2.4
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=705be5849293844f499a85280e793941b0eacb362b90d49d85ae8308e4c5b63c
LINUXDROID_PKG_SRCURL=https://github.com/realnc/frobtads/releases/download/$LINUXDROID_PKG_VERSION/frobtads-$LINUXDROID_PKG_VERSION.tar.bz2
LINUXDROID_PKG_RM_AFTER_INSTALL="share/frobtads/tads3/doc share/frobtads/tads3/lib/webuires"
LINUXDROID_PKG_DEPENDS="ncurses, libcurl"
