LINUXDROID_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/pkg-config/
LINUXDROID_PKG_DESCRIPTION="Helper tool used when compiling applications and libraries"
LINUXDROID_PKG_VERSION=0.29.2
LINUXDROID_PKG_SRCURL=https://pkgconfig.freedesktop.org/releases/pkg-config-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591
LINUXDROID_PKG_DEPENDS="glib"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/*-pkg-config"

linuxdroid_step_pre_configure () {
	rm -Rf $LINUXDROID_PREFIX/bin/*pkg-config
}
