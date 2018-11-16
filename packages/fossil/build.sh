LINUXDROID_PKG_HOMEPAGE=https://www.fossil-scm.org
LINUXDROID_PKG_DESCRIPTION="DSCM with built-in wiki, http interface and server, tickets database"
LINUXDROID_PKG_API_LEVEL=23
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_VERSION=2.7
LINUXDROID_PKG_SHA256=2c24359131d7495e47dc95021eb35f1ba408ded9087e36370d94742a4011033c
LINUXDROID_PKG_SRCURL=https://www.fossil-scm.org/index.html/uv/fossil-src-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libsqlite, openssl"

linuxdroid_step_pre_configure () {
	# Avoid mixup of flags between cross compilation
	# and native build.
	CC="$CC $CFLAGS $LDFLAGS"
	unset CFLAGS LDFLAGS
}

linuxdroid_step_configure () {
	$LINUXDROID_PKG_SRCDIR/configure \
		--prefix=$LINUXDROID_PREFIX \
		--host=$LINUXDROID_HOST_PLATFORM \
		--json \
		--disable-internal-sqlite \
		--with-openssl=$LINUXDROID_PREFIX \
		--with-zlib=auto
}

