MININIX_PKG_HOMEPAGE=https://nodejs.org/
MININIX_PKG_DESCRIPTION="Platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications"
MININIX_PKG_VERSION=8.13.0
MININIX_PKG_SHA256=2aa99474a336c6339d14f08cc27d387c5168e6fb6cbcaaea1d5ff7aa89642de2
MININIX_PKG_SRCURL=https://nodejs.org/dist/v${MININIX_PKG_VERSION}/node-v${MININIX_PKG_VERSION}.tar.xz
# Note that we do not use a shared libuv to avoid an issue with the Android
# linker, which does not use symbols of linked shared libraries when resolving
# symbols on dlopen(). See https://github.com/mininix/mininix-packages/issues/462.
MININIX_PKG_DEPENDS="openssl, c-ares"
MININIX_PKG_RM_AFTER_INSTALL="lib/node_modules/npm/html lib/node_modules/npm/make.bat share/systemtap lib/dtrace"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_CONFLICTS="nodejs"

mininix_step_configure () {
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

	# See note above MININIX_PKG_DEPENDS why we do not use a shared libuv.
	./configure \
		--prefix=$MININIX_PREFIX \
		--dest-cpu=$DEST_CPU \
		--dest-os=android \
		--shared-cares \
		--shared-openssl \
		--without-inspector \
		--without-intl \
		--without-snapshot \
		--cross-compiling
}
