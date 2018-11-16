LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gtypist/
LINUXDROID_PKG_DESCRIPTION="Universal typing tutor"
LINUXDROID_PKG_VERSION=2.9.5
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gtypist/gtypist-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_SHA256=c13af40b12479f8219ffa6c66020618c0ce305ad305590fde02d2c20eb9cf977
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_ncursesw_ncurses_h=yes --enable-nls=no ac_cv_header_libintl_h=no"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/emacs/site-lisp bin/typefortune share/man/man1/typefortune.1"
