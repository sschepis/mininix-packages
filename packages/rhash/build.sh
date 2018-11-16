LINUXDROID_PKG_HOMEPAGE=https://github.com/rhash/RHash
LINUXDROID_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
LINUXDROID_PKG_VERSION=1.3.6
LINUXDROID_PKG_REVISION=4
LINUXDROID_PKG_SHA256=964df972b60569b5cb35ec989ced195ab8ea514fc46a74eab98e86569ffbcf92
LINUXDROID_PKG_SRCURL=https://github.com/rhash/RHash/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="openssl"
LINUXDROID_PKG_BUILD_IN_SRC=true
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_CONFLICTS=librhash
LINUXDROID_PKG_REPLACES=librhash

linuxdroid_step_make () {
	CFLAGS="-DOPENSSL_RUNTIME $CPPFLAGS $CFLAGS"
	make -j $LINUXDROID_MAKE_PROCESSES \
		ADDCFLAGS="$CFLAGS" \
		ADDLDFLAGS="$LDFLAGS"
}

linuxdroid_step_make_install () {
	make install install-pkg-config
	make -C librhash install-headers

	ln -sf $LINUXDROID_PREFIX/lib/librhash.so.0 $LINUXDROID_PREFIX/lib/librhash.so
}
