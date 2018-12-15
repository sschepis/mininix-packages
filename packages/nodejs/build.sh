MININIX_PKG_HOMEPAGE=https://nodejs.org/
MININIX_PKG_DESCRIPTION="Platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications"
MININIX_PKG_VERSION=11.3.0
MININIX_PKG_SHA256=08c4a159242af4c68752260d59ed209fc86b073ee669443fa591eecacb6093da
MININIX_PKG_SRCURL=https://nodejs.org/dist/v${MININIX_PKG_VERSION}/node-v${MININIX_PKG_VERSION}.tar.xz
# symbols on dlopen(). See https://github.com/mininix/mininix-packages/issues/462.
MININIX_PKG_DEPENDS="openssl, c-ares, libicu"
MININIX_PKG_RM_AFTER_INSTALL="lib/node_modules/npm/html lib/node_modules/npm/make.bat share/systemtap lib/dtrace"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_CONFLICTS="nodejs-lts, nodejs-current"
MININIX_PKG_REPLACES="nodejs-current"

mininix_step_configure () {
	local DEST_CPU
	if [ $MININIX_ARCH = "arm" ]; then
		DEST_CPU="arm"
	elif [ $MININIX_ARCH = "i686" ]; then
		DEST_CPU="ia32"
	elif [ $MININIX_ARCH = "aarch64" ]; then
		DEST_CPU="arm64"
	elif [ $MININIX_ARCH = "x86_64" ]; then
		DEST_CPU="x64"
	else
		mininix_error_exit "Unsupported arch '$MININIX_ARCH'"
	fi

	export GYP_DEFINES="host_os=linux"
	export CC_host=gcc
	export CXX_host=g++
	export LINK_host=g++

	# See note above MININIX_PKG_DEPENDS why we do not use a shared libuv.
	./configure \
		--prefix=$MININIX_PREFIX \
		--dest-cpu=$DEST_CPU \
		--dest-os=android \
		--shared-cares \
		--shared-openssl \
		--without-inspector \
		--with-intl=system-icu \
		--without-snapshot \
		--cross-compiling

	perl -p -i -e 's/LIBS := \$\(LIBS\)/LIBS := -lpthread/' \
		$MININIX_PKG_SRCDIR/out/deps/v8/gypfiles/torque.host.mk
}
