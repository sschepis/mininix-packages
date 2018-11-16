LINUXDROID_PKG_HOMEPAGE=https://aria2.github.io
LINUXDROID_PKG_DESCRIPTION="Download utility supporting HTTP/HTTPS, FTP, BitTorrent and Metalink"
LINUXDROID_PKG_VERSION=1.34.0
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SHA256=3a44a802631606e138a9e172a3e9f5bcbaac43ce2895c1d8e2b46f30487e77a3
LINUXDROID_PKG_SRCURL=https://github.com/aria2/aria2/releases/download/release-${LINUXDROID_PKG_VERSION}/aria2-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="c-ares, openssl, libxml2"
# sqlite3 is only used for loading cookies from firefox or chrome:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
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
