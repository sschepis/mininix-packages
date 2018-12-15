MININIX_PKG_HOMEPAGE=https://www.openssl.org/
MININIX_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
MININIX_PKG_DEPENDS="ca-certificates"
MININIX_PKG_VERSION=1.1.1a
MININIX_PKG_SHA256=fc20130f8b7cbd2fb918b2f14e2f429e109c31ddd0fb38fc5d71d9ffed3f9f41
MININIX_PKG_SRCURL=https://www.openssl.org/source/openssl-${MININIX_PKG_VERSION/\~/-}.tar.gz
MININIX_PKG_RM_AFTER_INSTALL="bin/c_rehash etc/ssl/misc"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_CONFLICTS="libcurl (<< 7.61.0-1)"

mininix_step_configure () {
	CFLAGS+=" -DNO_SYSLOG"
	if [ $MININIX_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi

	perl -p -i -e "s@MININIX_CFLAGS@$CFLAGS@g" Configure
	rm -Rf $MININIX_PREFIX/lib/libcrypto.* $MININIX_PREFIX/lib/libssl.*
	test $MININIX_ARCH = "arm" && MININIX_OPENSSL_PLATFORM="android-arm"
	test $MININIX_ARCH = "aarch64" && MININIX_OPENSSL_PLATFORM="android-arm64"
	test $MININIX_ARCH = "i686" && MININIX_OPENSSL_PLATFORM="android-x86"
	test $MININIX_ARCH = "x86_64" && MININIX_OPENSSL_PLATFORM="android-x86_64"
	# If enabling zlib-dynamic we need "zlib-dynamic" instead of "no-comp no-dso":
	./Configure $MININIX_OPENSSL_PLATFORM \
		--prefix=$MININIX_PREFIX \
		--openssldir=$MININIX_PREFIX/etc/tls \
		shared \
		no-ssl \
		no-comp \
		no-dso \
		no-hw \
		no-srp \
		no-tests
}

mininix_step_make () {
	make depend
	make -j $MININIX_MAKE_PROCESSES all
}

mininix_step_make_install () {
	# "install_sw" instead of "install" to not install man pages:
	make -j 1 install_sw MANDIR=$MININIX_PREFIX/share/man MANSUFFIX=.ssl

	cp apps/openssl.cnf $MININIX_PREFIX/etc/tls/openssl.cnf
}
