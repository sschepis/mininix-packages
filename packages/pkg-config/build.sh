MININIX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/pkg-config/
MININIX_PKG_DESCRIPTION="Helper tool used when compiling applications and libraries"
MININIX_PKG_VERSION=0.29.2
MININIX_PKG_SRCURL=https://pkgconfig.freedesktop.org/releases/pkg-config-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=6fc69c01688c9458a57eb9a1664c9aba372ccda420a02bf4429fe610e7e7d591
MININIX_PKG_DEPENDS="glib"
MININIX_PKG_RM_AFTER_INSTALL="bin/*-pkg-config"

mininix_step_pre_configure () {
	rm -Rf $MININIX_PREFIX/bin/*pkg-config
}
