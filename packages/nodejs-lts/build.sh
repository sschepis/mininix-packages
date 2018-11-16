LINUXDROID_PKG_HOMEPAGE=https://nodejs.org/
LINUXDROID_PKG_DESCRIPTION="Platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications"
LINUXDROID_PKG_VERSION=8.12.0
LINUXDROID_PKG_SHA256=5a9dff58016c18fb4bf902d963b124ff058a550ebcd9840c677757387bce419a
LINUXDROID_PKG_SRCURL=https://nodejs.org/dist/v${LINUXDROID_PKG_VERSION}/node-v${LINUXDROID_PKG_VERSION}.tar.xz
# Note that we do not use a shared libuv to avoid an issue with the Android
# linker, which does not use symbols of linked shared libraries when resolving
# symbols on dlopen(). See https://github.com/linuxdroid/linuxdroid-packages/issues/462.
LINUXDROID_PKG_DEPENDS="openssl, c-ares"
LINUXDROID_PKG_RM_AFTER_INSTALL="lib/node_modules/npm/html lib/node_modules/npm/make.bat share/systemtap lib/dtrace"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_CONFLICTS="nodejs"

linuxdroid_step_configure () {
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

	# See note above LINUXDROID_PKG_DEPENDS why we do not use a shared libuv.
	./configure \
		--prefix=$LINUXDROID_PREFIX \
		--dest-cpu=$DEST_CPU \
		--dest-os=android \
		--shared-cares \
		--shared-openssl \
		--shared-zlib \
		--without-inspector \
		--without-intl \
		--without-snapshot \
		--cross-compiling
}
