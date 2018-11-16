LINUXDROID_PKG_HOMEPAGE=https://libwebsockets.org
LINUXDROID_PKG_DESCRIPTION="Lightweight C websockets library"
LINUXDROID_PKG_VERSION=3.0.1
LINUXDROID_PKG_SHA256=cb0cdd8d0954fcfd97a689077568f286cdbb44111883e0a85d29860449c47cbf
LINUXDROID_PKG_SRCURL=https://github.com/warmcat/libwebsockets/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="openssl"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="-DLWS_WITHOUT_TESTAPPS=ON -DLWS_WITH_STATIC=OFF"
LINUXDROID_PKG_RM_AFTER_INSTALL="lib/pkgconfig/libwebsockets_static.pc"

linuxdroid_step_pre_configure() {
	# For syslog():
	LDFLAGS+=" -llog"
}
