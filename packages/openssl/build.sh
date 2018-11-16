LINUXDROID_PKG_HOMEPAGE=https://www.openssl.org/
LINUXDROID_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
LINUXDROID_PKG_DEPENDS="ca-certificates"
LINUXDROID_PKG_VERSION=1.1.1
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_SHA256=2836875a0f89c03d0fdf483941512613a50cfb421d6fd94b9f41d7279d586a3d
LINUXDROID_PKG_SRCURL=https://www.openssl.org/source/openssl-${LINUXDROID_PKG_VERSION/\~/-}.tar.gz
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/c_rehash etc/ssl/misc"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_CONFLICTS="libcurl (<< 7.61.0-1)"

linuxdroid_step_configure () {
	CFLAGS+=" -DNO_SYSLOG"
	if [ $LINUXDROID_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi

	perl -p -i -e "s@LINUXDROID_CFLAGS@$CFLAGS@g" Configure
	rm -Rf $LINUXDROID_PREFIX/lib/libcrypto.* $LINUXDROID_PREFIX/lib/libssl.*
	test $LINUXDROID_ARCH = "arm" && LINUXDROID_OPENSSL_PLATFORM="android-arm"
	test $LINUXDROID_ARCH = "aarch64" && LINUXDROID_OPENSSL_PLATFORM="android-arm64"
	test $LINUXDROID_ARCH = "i686" && LINUXDROID_OPENSSL_PLATFORM="android-x86"
	test $LINUXDROID_ARCH = "x86_64" && LINUXDROID_OPENSSL_PLATFORM="android-x86_64"
	# If enabling zlib-dynamic we need "zlib-dynamic" instead of "no-comp no-dso":
	./Configure $LINUXDROID_OPENSSL_PLATFORM \
		--prefix=$LINUXDROID_PREFIX \
		--openssldir=$LINUXDROID_PREFIX/etc/tls \
		shared \
		no-ssl \
		no-comp \
		no-dso \
		no-hw \
		no-srp \
		no-tests
}

linuxdroid_step_make () {
	make depend
	make -j $LINUXDROID_MAKE_PROCESSES all
}

linuxdroid_step_make_install () {
	# "install_sw" instead of "install" to not install man pages:
	make -j 1 install_sw MANDIR=$LINUXDROID_PREFIX/share/man MANSUFFIX=.ssl

	cp apps/openssl.cnf $LINUXDROID_PREFIX/etc/tls/openssl.cnf
}
