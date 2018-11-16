LINUXDROID_PKG_HOMEPAGE=https://php.net
LINUXDROID_PKG_DESCRIPTION="Server-side, HTML-embedded scripting language"
LINUXDROID_PKG_VERSION=7.2.12
LINUXDROID_PKG_SHA256=989c04cc879ee71a5e1131db867f3c5102f1f7565f805e2bb8bde33f93147fe1
LINUXDROID_PKG_SRCURL=https://secure.php.net/distributions/php-${LINUXDROID_PKG_VERSION}.tar.xz
# Build native php for phar to build (see pear-Makefile.frag.patch):
LINUXDROID_PKG_HOSTBUILD=true
# Build the native php without xml support as we only need phar:
LINUXDROID_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear"
LINUXDROID_PKG_DEPENDS="libandroid-glob, libxml2, liblzma, openssl, pcre, libbz2, libcrypt, libcurl, libgd, readline, freetype"
# mysql modules were initially shared libs
LINUXDROID_PKG_CONFLICTS="php-mysql"
LINUXDROID_PKG_REPLACES="php-mysql"
LINUXDROID_PKG_RM_AFTER_INSTALL="php/php/fpm"

LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_res_nsearch=no
--enable-bcmath
--enable-calendar
--enable-exif
--enable-gd-native-ttf=$LINUXDROID_PREFIX
--enable-mbstring
--enable-opcache
--enable-pcntl
--enable-sockets
--enable-zip
--mandir=$LINUXDROID_PREFIX/share/man
--with-bz2=$LINUXDROID_PREFIX
--with-curl=$LINUXDROID_PREFIX
--with-freetype-dir=$LINUXDROID_PREFIX
--with-gd=$LINUXDROID_PREFIX
--with-iconv=$LINUXDROID_PREFIX
--with-libxml-dir=$LINUXDROID_PREFIX
--with-openssl=$LINUXDROID_PREFIX
--with-pcre-regex=$LINUXDROID_PREFIX
--with-png-dir=$LINUXDROID_PREFIX
--with-readline=$LINUXDROID_PREFIX
--with-zlib
--with-pgsql=shared,$LINUXDROID_PREFIX
--with-pdo-pgsql=shared,$LINUXDROID_PREFIX
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-mysql-sock=$LINUXDROID_PREFIX/tmp/mysqld.sock
--with-apxs2=$LINUXDROID_PREFIX/bin/apxs
--enable-fpm
--sbindir=$LINUXDROID_PREFIX/bin
"

linuxdroid_step_pre_configure () {
	LDFLAGS+=" -landroid-glob -llog"

	export PATH=$PATH:$LINUXDROID_PKG_HOSTBUILD_DIR/sapi/cli/
	export NATIVE_PHP_EXECUTABLE=$LINUXDROID_PKG_HOSTBUILD_DIR/sapi/cli/php

	# Run autoconf since we have patched config.m4 files.
	autoconf

	export EXTENSION_DIR=$LINUXDROID_PREFIX/lib/php
}

linuxdroid_step_post_configure () {
	# Avoid src/ext/gd/gd.c trying to include <X11/xpm.h>:
	sed -i 's/#define HAVE_GD_XPM 1//' $LINUXDROID_PKG_BUILDDIR/main/php_config.h
	# Avoid src/ext/standard/dns.c trying to use struct __res_state:
	sed -i 's/#define HAVE_RES_NSEARCH 1//' $LINUXDROID_PKG_BUILDDIR/main/php_config.h
}

linuxdroid_step_post_make_install () {
	mkdir -p $LINUXDROID_PREFIX/etc/php-fpm.d
	cp sapi/fpm/php-fpm.conf $LINUXDROID_PREFIX/etc/
	cp sapi/fpm/www.conf $LINUXDROID_PREFIX/etc/php-fpm.d/

	sed -i 's/SED=.*/SED=sed/' $LINUXDROID_PREFIX/bin/phpize
}
