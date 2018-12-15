MININIX_PKG_HOMEPAGE=https://subversion.apache.org
MININIX_PKG_DESCRIPTION="Centralized version control system characterized by its simplicity"
MININIX_PKG_VERSION=1.11.0
MININIX_PKG_SHA256=87c44344b074ac2e9ed7ca9675fb1e5b197051c3deecfe5934e5f6aefbf83e56
MININIX_PKG_SRCURL=https://www.apache.org/dist/subversion/subversion-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="apr, apr-util, serf, libexpat, libsqlite, liblz4, utf8proc"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-sasl --without-libmagic"

mininix_step_pre_configure() {
	CFLAGS+=" -std=c11"
}
