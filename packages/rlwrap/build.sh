MININIX_PKG_HOMEPAGE=https://github.com/hanslub42/rlwrap
MININIX_PKG_DESCRIPTION="Wrapper using readline to enable editing of keyboard input for commands"
MININIX_PKG_VERSION=0.43
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://fossies.org/linux/privat/rlwrap-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=4ed39d0399a82942e2edc9feed6e7736f898c58d531d47ce543a063c17f41f22
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_grantpt=yes
ac_cv_func_unlockpt=yes
ac_cv_lib_util_openpty=no
ptyttylib_cv_ptys=STREAMS
"
MININIX_PKG_DEPENDS="ncurses, readline"
