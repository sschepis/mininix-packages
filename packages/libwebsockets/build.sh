MININIX_PKG_HOMEPAGE=https://libwebsockets.org
MININIX_PKG_DESCRIPTION="Lightweight C websockets library"
MININIX_PKG_VERSION=3.1.0
MININIX_PKG_SHA256=db948be74c78fc13f1f1a55e76707d7baae3a1c8f62b625f639e8f2736298324
MININIX_PKG_SRCURL=https://github.com/warmcat/libwebsockets/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="openssl"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="-DLWS_WITHOUT_TESTAPPS=ON -DLWS_WITH_STATIC=OFF"
MININIX_PKG_RM_AFTER_INSTALL="lib/pkgconfig/libwebsockets_static.pc"

mininix_step_pre_configure() {
	# For syslog():
	LDFLAGS+=" -llog"
}
