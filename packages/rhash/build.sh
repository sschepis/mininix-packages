MININIX_PKG_HOMEPAGE=https://github.com/rhash/RHash
MININIX_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
MININIX_PKG_VERSION=1.3.6
MININIX_PKG_REVISION=4
MININIX_PKG_SHA256=964df972b60569b5cb35ec989ced195ab8ea514fc46a74eab98e86569ffbcf92
MININIX_PKG_SRCURL=https://github.com/rhash/RHash/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="openssl"
MININIX_PKG_BUILD_IN_SRC=true
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_CONFLICTS=librhash
MININIX_PKG_REPLACES=librhash

mininix_step_make () {
	CFLAGS="-DOPENSSL_RUNTIME $CPPFLAGS $CFLAGS"
	make -j $MININIX_MAKE_PROCESSES \
		ADDCFLAGS="$CFLAGS" \
		ADDLDFLAGS="$LDFLAGS"
}

mininix_step_make_install () {
	make install install-pkg-config
	make -C librhash install-headers

	ln -sf $MININIX_PREFIX/lib/librhash.so.0 $MININIX_PREFIX/lib/librhash.so
}
