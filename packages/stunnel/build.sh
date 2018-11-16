LINUXDROID_PKG_HOMEPAGE=https://www.stunnel.org/
LINUXDROID_PKG_DESCRIPTION="Socket wrapper which can provide TLS support to ordinary applications"
LINUXDROID_PKG_VERSION=5.49
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=3d6641213a82175c19f23fde1c3d1c841738385289eb7ca1554f4a58b96d955e
LINUXDROID_PKG_SRCURL=https://www.stunnel.org/downloads/stunnel-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="openssl, libutil"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-shared --with-ssl=$LINUXDROID_PREFIX --disable-fips"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/stunnel3 share/man/man8/stunnel.*.8"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -llog"
}
