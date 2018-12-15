MININIX_PKG_HOMEPAGE=https://php.net
MININIX_PKG_DESCRIPTION="Server-side, HTML-embedded scripting language"
MININIX_PKG_VERSION=7.2.12
MININIX_PKG_SHA256=989c04cc879ee71a5e1131db867f3c5102f1f7565f805e2bb8bde33f93147fe1
MININIX_PKG_SRCURL=https://secure.php.net/distributions/php-${MININIX_PKG_VERSION}.tar.xz
# Build native php for phar to build (see pear-Makefile.frag.patch):
MININIX_PKG_HOSTBUILD=true
# Build the native php without xml support as we only need phar:
MININIX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear"
MININIX_PKG_DEPENDS="libandroid-glob, libxml2, liblzma, openssl, pcre, libbz2, libcrypt, libcurl, libgd, readline, freetype"
# mysql modules were initially shared libs
MININIX_PKG_CONFLICTS="php-mysql"
MININIX_PKG_REPLACES="php-mysql"
MININIX_PKG_RM_AFTER_INSTALL="php/php/fpm"

MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_res_nsearch=no
--enable-bcmath
--enable-calendar
--enable-exif
--enable-gd-native-ttf=$MININIX_PREFIX
--enable-mbstring
--enable-opcache
--enable-pcntl
--enable-sockets
--enable-zip
--mandir=$MININIX_PREFIX/share/man
--with-bz2=$MININIX_PREFIX
--with-curl=$MININIX_PREFIX
--with-freetype-dir=$MININIX_PREFIX
--with-gd=$MININIX_PREFIX
--with-iconv=$MININIX_PREFIX
--with-libxml-dir=$MININIX_PREFIX
--with-openssl=$MININIX_PREFIX
--with-pcre-regex=$MININIX_PREFIX
--with-png-dir=$MININIX_PREFIX
--with-readline=$MININIX_PREFIX
--with-zlib
--with-pgsql=shared,$MININIX_PREFIX
--with-pdo-pgsql=shared,$MININIX_PREFIX
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-mysql-sock=$MININIX_PREFIX/tmp/mysqld.sock
--with-apxs2=$MININIX_PREFIX/bin/apxs
--enable-fpm
--sbindir=$MININIX_PREFIX/bin
"

mininix_step_pre_configure () {
	LDFLAGS+=" -landroid-glob -llog"

	export PATH=$PATH:$MININIX_PKG_HOSTBUILD_DIR/sapi/cli/
	export NATIVE_PHP_EXECUTABLE=$MININIX_PKG_HOSTBUILD_DIR/sapi/cli/php

	# Run autoconf since we have patched config.m4 files.
	autoconf

	export EXTENSION_DIR=$MININIX_PREFIX/lib/php
}

mininix_step_post_configure () {
	# Avoid src/ext/gd/gd.c trying to include <X11/xpm.h>:
	sed -i 's/#define HAVE_GD_XPM 1//' $MININIX_PKG_BUILDDIR/main/php_config.h
	# Avoid src/ext/standard/dns.c trying to use struct __res_state:
	sed -i 's/#define HAVE_RES_NSEARCH 1//' $MININIX_PKG_BUILDDIR/main/php_config.h
}

mininix_step_post_make_install () {
	mkdir -p $MININIX_PREFIX/etc/php-fpm.d
	cp sapi/fpm/php-fpm.conf $MININIX_PREFIX/etc/
	cp sapi/fpm/www.conf $MININIX_PREFIX/etc/php-fpm.d/

	sed -i 's/SED=.*/SED=sed/' $MININIX_PREFIX/bin/phpize
}
