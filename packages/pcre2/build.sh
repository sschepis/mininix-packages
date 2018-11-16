LINUXDROID_PKG_HOMEPAGE=https://www.pcre.org
LINUXDROID_PKG_DESCRIPTION="Perl 5 compatible regular expression library"
LINUXDROID_PKG_VERSION=10.32
LINUXDROID_PKG_SHA256=f29e89cc5de813f45786580101aaee3984a65818631d4ddbda7b32f699b87c2e
LINUXDROID_PKG_SRCURL=https://ftp.pcre.org/pub/pcre/pcre2-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/pcre2-config"
LINUXDROID_PKG_RM_AFTER_INSTALL="
bin/pcre2grep
bin/pcre2test
share/man/man1/pcre2*.1
lib/libpcre2-posix.so
"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--enable-jit
--enable-pcre2-16
--enable-pcre2-32
"
