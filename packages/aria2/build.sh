MININIX_PKG_HOMEPAGE=https://aria2.github.io
MININIX_PKG_DESCRIPTION="Download utility supporting HTTP/HTTPS, FTP, BitTorrent and Metalink"
MININIX_PKG_VERSION=1.34.0
MININIX_PKG_REVISION=2
MININIX_PKG_SHA256=3a44a802631606e138a9e172a3e9f5bcbaac43ce2895c1d8e2b46f30487e77a3
MININIX_PKG_SRCURL=https://github.com/aria2/aria2/releases/download/release-${MININIX_PKG_VERSION}/aria2-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="c-ares, openssl, libxml2"
# sqlite3 is only used for loading cookies from firefox or chrome:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--with-openssl
--without-gnutls
--without-libuv
--without-sqlite3
--without-libssh2
ac_cv_func_basename=yes
ac_cv_func_getaddrinfo=yes
ac_cv_func_gettimeofday=yes
ac_cv_func_sleep=yes
ac_cv_func_usleep=yes
ac_cv_search_getaddrinfo=no
"
