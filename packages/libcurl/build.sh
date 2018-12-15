MININIX_PKG_HOMEPAGE=https://curl.haxx.se/
MININIX_PKG_DESCRIPTION="Easy-to-use client-side URL transfer library"
MININIX_PKG_DEPENDS="openssl (>= 1.1.1), libnghttp2"
MININIX_PKG_VERSION=7.61.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=a308377dbc9a16b2e994abd55455e5f9edca4e31666f8f8fcfe7a1a4aea419b9
MININIX_PKG_SRCURL=https://curl.haxx.se/download/curl-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-ntlm-wb=$MININIX_PREFIX/bin/ntlm_auth
--with-ca-bundle=$MININIX_PREFIX/etc/tls/cert.pem
--with-nghttp2
--without-libidn
--without-libidn2
--without-librtmp
--without-brotli
--with-ssl
"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/curl-config share/man/man1/curl-config.1"
