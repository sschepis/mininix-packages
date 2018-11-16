LINUXDROID_PKG_HOMEPAGE=https://nodejs.org/
LINUXDROID_PKG_DESCRIPTION="Platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications"
LINUXDROID_PKG_VERSION=11.1.0
LINUXDROID_PKG_SHA256=50279fb2cfea1eefc7d1a3ce5c4fecdd16131a4397867d1af839d47cda556d0a
LINUXDROID_PKG_SRCURL=https://nodejs.org/dist/v${LINUXDROID_PKG_VERSION}/node-v${LINUXDROID_PKG_VERSION}.tar.xz
# Note that we do not use a shared libuv to avoid an issue with the Android
# linker, which does not use symbols of linked shared libraries when resolving
# symbols on dlopen(). See https://github.com/linuxdroid/linuxdroid-packages/issues/462.
LINUXDROID_PKG_DEPENDS="openssl, c-ares, libicu"
LINUXDROID_PKG_RM_AFTER_INSTALL="lib/node_modules/npm/html lib/node_modules/npm/make.bat share/systemtap lib/dtrace"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_CONFLICTS="nodejs-lts, nodejs-current"
LINUXDROID_PKG_REPLACES="nodejs-current"

linuxdroid_step_configure () {
	local DEST_CPU
	if [ $LINUXDROID_ARCH = "arm" ]; then
		DEST_CPU="arm"
	elif [ $LINUXDROID_ARCH = "i686" ]; then
		DEST_CPU="ia32"
	elif [ $LINUXDROID_ARCH = "aarch64" ]; then
		DEST_CPU="arm64"
	elif [ $LINUXDROID_ARCH = "x86_64" ]; then
		DEST_CPU="x64"
	else
		linuxdroid_error_exit "Unsupported arch '$LINUXDROID_ARCH'"
	fi

	export GYP_DEFINES="host_os=linux"
	export CC_host=gcc
	export CXX_host=g++
	export LINK_host=g++

	# See note above LINUXDROID_PKG_DEPENDS why we do not use a shared libuv.
	./configure \
		--prefix=$LINUXDROID_PREFIX \
		--dest-cpu=$DEST_CPU \
		--dest-os=android \
		--shared-cares \
		--shared-openssl \
		--shared-zlib \
		--without-inspector \
		--with-intl=system-icu \
		--without-snapshot \
		--cross-compiling

	perl -p -i -e 's/LIBS := \$\(LIBS\)/LIBS := -lpthread/' \
		$LINUXDROID_PKG_SRCDIR/out/deps/v8/gypfiles/torque.host.mk
}
