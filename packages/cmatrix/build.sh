MININIX_PKG_HOMEPAGE=https://github.com/abishekvashok/cmatrix
MININIX_PKG_DESCRIPTION="Command producing a Matrix-style animation"
local _REAL_VERSION=1.2
MININIX_PKG_VERSION=${_REAL_VERSION}b
MININIX_PKG_SHA256=6b0b9aff4585147843c4cf8a8c9c6048500f66dc4887a38922197dfa326b57c8
MININIX_PKG_SRCURL=https://github.com/abishekvashok/cmatrix/archive/${_REAL_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MININIX_PREFIX/share/man"
MININIX_PKG_DEPENDS="ncurses"

mininix_step_pre_configure () {
	export ac_cv_file__usr_lib_kbd_consolefonts=no
	export ac_cv_file__usr_share_consolefonts=no
	export ac_cv_file__usr_lib_X11_fonts_misc=no
	export ac_cv_file__usr_X11R6_lib_X11_fonts_misc=no
}
