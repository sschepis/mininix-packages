LINUXDROID_PKG_HOMEPAGE=https://www.webmproject.org
LINUXDROID_PKG_DESCRIPTION="VP8 & VP9 Codec SDK"
LINUXDROID_PKG_VERSION=1.7.0
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=1fec931eb5c94279ad219a5b6e0202358e94a93a90cfb1603578c326abfc1238
LINUXDROID_PKG_SRCURL=https://github.com/webmproject/libvpx/archive/v${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_configure () {
	# Force fresh install of header files:
	rm -Rf $LINUXDROID_PREFIX/include/vpx

	export LD=$CC

	if [ $LINUXDROID_ARCH = "arm" ]; then
		export AS=$LINUXDROID_HOST_PLATFORM-as
		_CONFIGURE_TARGET="--target=armv7-android-gcc"
	elif [ $LINUXDROID_ARCH = "i686" ]; then
		export AS=yasm
		_CONFIGURE_TARGET="--target=x86-android-gcc"
	elif [ $LINUXDROID_ARCH = "aarch64" ]; then
		_CONFIGURE_TARGET="--force-target=arm64-v8a-android-gcc"
	elif [ $LINUXDROID_ARCH = "x86_64" ]; then
		export AS=yasm
		_CONFIGURE_TARGET="--target=x86_64-android-gcc"
	else
		linuxdroid_error_exit "Unsupported arch: $LINUXDROID_ARCH"
	fi

	# For --disable-realtime-only, see
	# https://bugs.chromium.org/p/webm/issues/detail?id=800
	# "The issue is that on android we soft enable realtime only.
	#  [..] You can enable non-realtime by setting --disable-realtime-only"
	# Discovered in https://github.com/linuxdroid/linuxdroid-packages/issues/554
	#CROSS=${LINUXDROID_HOST_PLATFORM}- CC=clang CXX=clang++ $LINUXDROID_PKG_SRCDIR/configure \
	$LINUXDROID_PKG_SRCDIR/configure \
		$_CONFIGURE_TARGET \
		--prefix=$LINUXDROID_PREFIX \
		--disable-examples \
		--disable-realtime-only \
		--disable-unit-tests \
		--enable-pic \
		--enable-vp8 \
		--enable-shared \
		--enable-small
}
