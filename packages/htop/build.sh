MININIX_PKG_HOMEPAGE=https://hisham.hm/htop/
MININIX_PKG_DESCRIPTION="Interactive process viewer for Linux"
MININIX_PKG_VERSION=2.2.0
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=d9d6826f10ce3887950d709b53ee1d8c1849a70fa38e91d5896ad8cbc6ba3c57
MININIX_PKG_SRCURL=http://hisham.hm/htop/releases/${MININIX_PKG_VERSION}/htop-${MININIX_PKG_VERSION}.tar.gz
# htop checks setlocale() return value for UTF-8 support, so use libandroid-support.
MININIX_PKG_DEPENDS="ncurses, libandroid-support"
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_ncursesw6_addnwstr=yes
LIBS=-landroid-support
"
