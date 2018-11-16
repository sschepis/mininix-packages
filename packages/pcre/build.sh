LINUXDROID_PKG_HOMEPAGE=https://www.pcre.org
LINUXDROID_PKG_DESCRIPTION="Library implementing regular expression pattern matching using the same syntax and semantics as Perl 5"
LINUXDROID_PKG_VERSION=8.42
LINUXDROID_PKG_SHA256=2cd04b7c887808be030254e8d77de11d3fe9d4505c39d4b15d2664ffe8bf9301
LINUXDROID_PKG_SRCURL=https://ftp.pcre.org/pub/pcre/pcre-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/pcre-config"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/pcregrep bin/pcretest share/man/man1/pcre*.1 lib/libpcreposix.so lib/libpcreposix.so.0 lib/libpcreposix.so.0.0.2"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-cpp --enable-jit --enable-utf8 --enable-unicode-properties"
