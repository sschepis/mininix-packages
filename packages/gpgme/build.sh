MININIX_PKG_HOMEPAGE=https://www.gnupg.org/related_software/gpgme/
MININIX_PKG_DESCRIPTION="Library designed to make access to GnuPG easier"
MININIX_PKG_DEPENDS="gnupg (>= 2.2.9-1), libassuan, libgpg-error"
MININIX_PKG_DEVPACKAGE_DEPENDS="libgpg-error-dev"
MININIX_PKG_VERSION=1.11.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=2d1b111774d2e3dd26dcd7c251819ce4ef774ec5e566251eb9308fa7542fbd6f
MININIX_PKG_SRCURL=ftp://ftp.gnupg.org/gcrypt/gpgme/gpgme-${MININIX_PKG_VERSION}.tar.bz2
# Use "--disable-gpg-test" to avoid "No rule to make target `../../src/libgpgme-pthread.la":
# Use "--enable-languages=no" to only build the C library.
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gpg-test
--enable-languages=no
--with-gpg=$MININIX_PREFIX/bin/gpg2
--without-g13
--without-gpgconf
--without-gpgsm
"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/gpgme-config"
