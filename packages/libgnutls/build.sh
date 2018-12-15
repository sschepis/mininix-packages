MININIX_PKG_HOMEPAGE=https://www.gnutls.org/
MININIX_PKG_DESCRIPTION="Secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them"
MININIX_PKG_DEPENDS="libgmp, libnettle, ca-certificates, libidn2, libunistring"
MININIX_PKG_VERSION=3.5.19
MININIX_PKG_SHA256=1936eb64f03aaefd6eb16cef0567457777618573826b94d03376bb6a4afadc44
MININIX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnutls/v${MININIX_PKG_VERSION:0:3}/gnutls-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEVPACKAGE_DEPENDS="libidn2-dev, libnettle-dev"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-cxx
--disable-hardware-acceleration
--disable-openssl-compatibility
--with-default-trust-store-file=$MININIX_PREFIX/etc/tls/cert.pem
--with-system-priority-file=${MININIX_PREFIX}/etc/gnutls/default-priorities
--with-included-libtasn1
--without-p11-kit
"
