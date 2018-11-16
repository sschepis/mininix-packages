LINUXDROID_PKG_HOMEPAGE=https://transmissionbt.com/
LINUXDROID_PKG_DESCRIPTION="Easy, lean and powerful BitTorrent client"
LINUXDROID_PKG_DEPENDS="libevent, openssl, libcurl"
LINUXDROID_PKG_VERSION=2.94
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://github.com/transmission/transmission/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=440c2fd0f89b1ab59d8a4b79ecd7bffd61bc000e36fb5b6c8e88142a4fadbb1f
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk --enable-lightweight --cache-file=linuxdroid_configure.cache"

linuxdroid_step_pre_configure() {
	./autogen.sh
	# liblog for android logging in syslog hack:
	LDFLAGS+=" -llog"

	echo "ac_cv_func_getmntent=no" >> linuxdroid_configure.cache
	echo "ac_cv_search_getmntent=false" >> linuxdroid_configure.cache
	chmod a-w linuxdroid_configure.cache
}
