MININIX_PKG_HOMEPAGE=https://www.fossil-scm.org
MININIX_PKG_DESCRIPTION="DSCM with built-in wiki, http interface and server, tickets database"
MININIX_PKG_API_LEVEL=23
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_VERSION=2.7
MININIX_PKG_SHA256=2c24359131d7495e47dc95021eb35f1ba408ded9087e36370d94742a4011033c
MININIX_PKG_SRCURL=https://www.fossil-scm.org/index.html/uv/fossil-src-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libsqlite, openssl"

mininix_step_pre_configure () {
	# Avoid mixup of flags between cross compilation
	# and native build.
	CC="$CC $CFLAGS $LDFLAGS"
	unset CFLAGS LDFLAGS
}

mininix_step_configure () {
	$MININIX_PKG_SRCDIR/configure \
		--prefix=$MININIX_PREFIX \
		--host=$MININIX_HOST_PLATFORM \
		--json \
		--disable-internal-sqlite \
		--with-openssl=$MININIX_PREFIX \
		--with-zlib=auto
}

