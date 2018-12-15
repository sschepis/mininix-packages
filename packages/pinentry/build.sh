MININIX_PKG_HOMEPAGE=https://www.gnupg.org/related_software/pinentry/index.html
MININIX_PKG_DESCRIPTION="Dialog allowing secure password entry"
MININIX_PKG_VERSION=1.1.0
MININIX_PKG_SHA256=68076686fa724a290ea49cdf0d1c0c1500907d1b759a3bcbfbec0293e8f56570
MININIX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/pinentry/pinentry-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="libandroid-support, libassuan, ncurses"
MININIX_PKG_BUILD_DEPENDS="libgpg-error"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-pinentry-fltk"
