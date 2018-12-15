MININIX_PKG_HOMEPAGE=http://www.lighttpd.net
MININIX_PKG_DESCRIPTION="Fast webserver with minimal memory footprint"
MININIX_PKG_VERSION=1.4.52
MININIX_PKG_SHA256=27bc0991c530b7c6335e6efff2181934d3c1a1c516f7401ea71d8302cefda764
MININIX_PKG_SRCURL=http://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-bzip2 --with-openssl --with-pcre --with-zlib"
MININIX_PKG_DEPENDS="libbz2, openssl, pcre, libcrypt, libandroid-glob"
MININIX_PKG_RM_AFTER_INSTALL="bin/lighttpd-angel"

mininix_step_pre_configure () {
	# liblog for syslog:
	LDFLAGS="$LDFLAGS -llog -landroid-glob"
}
