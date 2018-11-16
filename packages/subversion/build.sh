LINUXDROID_PKG_HOMEPAGE=https://subversion.apache.org
LINUXDROID_PKG_DESCRIPTION="Centralized version control system characterized by its simplicity"
LINUXDROID_PKG_VERSION=1.11.0
LINUXDROID_PKG_SHA256=87c44344b074ac2e9ed7ca9675fb1e5b197051c3deecfe5934e5f6aefbf83e56
LINUXDROID_PKG_SRCURL=https://www.apache.org/dist/subversion/subversion-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="apr, apr-util, serf, libexpat, libsqlite, liblz4, utf8proc"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--without-sasl --without-libmagic"

linuxdroid_step_pre_configure() {
	CFLAGS+=" -std=c11"
}
