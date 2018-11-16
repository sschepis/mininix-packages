LINUXDROID_PKG_HOMEPAGE=https://www.gnupg.org/related_software/pinentry/index.html
LINUXDROID_PKG_DESCRIPTION="Dialog allowing secure password entry"
LINUXDROID_PKG_VERSION=1.1.0
LINUXDROID_PKG_SHA256=68076686fa724a290ea49cdf0d1c0c1500907d1b759a3bcbfbec0293e8f56570
LINUXDROID_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="libandroid-support, libassuan, ncurses"
LINUXDROID_PKG_BUILD_DEPENDS="libgpg-error"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-pinentry-fltk"
