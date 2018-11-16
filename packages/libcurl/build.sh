LINUXDROID_PKG_HOMEPAGE=https://curl.haxx.se/
LINUXDROID_PKG_DESCRIPTION="Easy-to-use client-side URL transfer library"
LINUXDROID_PKG_DEPENDS="openssl (>= 1.1.1), libnghttp2"
LINUXDROID_PKG_VERSION=7.61.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=a308377dbc9a16b2e994abd55455e5f9edca4e31666f8f8fcfe7a1a4aea419b9
LINUXDROID_PKG_SRCURL=https://curl.haxx.se/download/curl-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--enable-ntlm-wb=$LINUXDROID_PREFIX/bin/ntlm_auth
--with-ca-bundle=$LINUXDROID_PREFIX/etc/tls/cert.pem
--with-nghttp2
--without-libidn
--without-libidn2
--without-librtmp
--without-brotli
--with-ssl
"
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/curl-config share/man/man1/curl-config.1"
