MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/gtypist/
MININIX_PKG_DESCRIPTION="Universal typing tutor"
MININIX_PKG_VERSION=2.9.5
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gtypist/gtypist-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=c13af40b12479f8219ffa6c66020618c0ce305ad305590fde02d2c20eb9cf977
MININIX_PKG_DEPENDS="libandroid-support, ncurses"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_ncursesw_ncurses_h=yes --enable-nls=no ac_cv_header_libintl_h=no"
MININIX_PKG_RM_AFTER_INSTALL="share/emacs/site-lisp bin/typefortune share/man/man1/typefortune.1"
