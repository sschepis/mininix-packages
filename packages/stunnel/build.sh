MININIX_PKG_HOMEPAGE=https://www.stunnel.org/
MININIX_PKG_DESCRIPTION="Socket wrapper which can provide TLS support to ordinary applications"
MININIX_PKG_VERSION=5.49
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=3d6641213a82175c19f23fde1c3d1c841738385289eb7ca1554f4a58b96d955e
MININIX_PKG_SRCURL=https://www.stunnel.org/downloads/stunnel-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="openssl, libutil"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-shared --with-ssl=$MININIX_PREFIX --disable-fips"
MININIX_PKG_RM_AFTER_INSTALL="bin/stunnel3 share/man/man8/stunnel.*.8"

mininix_step_pre_configure() {
	LDFLAGS+=" -llog"
}
