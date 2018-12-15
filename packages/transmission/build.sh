MININIX_PKG_HOMEPAGE=https://transmissionbt.com/
MININIX_PKG_DESCRIPTION="Easy, lean and powerful BitTorrent client"
MININIX_PKG_DEPENDS="libevent, openssl, libcurl"
MININIX_PKG_VERSION=2.94
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://github.com/transmission/transmission/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=440c2fd0f89b1ab59d8a4b79ecd7bffd61bc000e36fb5b6c8e88142a4fadbb1f
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk --enable-lightweight --cache-file=mininix_configure.cache"

mininix_step_pre_configure() {
	./autogen.sh
	# liblog for android logging in syslog hack:
	LDFLAGS+=" -llog"

	echo "ac_cv_func_getmntent=no" >> mininix_configure.cache
	echo "ac_cv_search_getmntent=false" >> mininix_configure.cache
	chmod a-w mininix_configure.cache
}
