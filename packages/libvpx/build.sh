MININIX_PKG_HOMEPAGE=https://www.webmproject.org
MININIX_PKG_DESCRIPTION="VP8 & VP9 Codec SDK"
MININIX_PKG_VERSION=1.7.0
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=1fec931eb5c94279ad219a5b6e0202358e94a93a90cfb1603578c326abfc1238
MININIX_PKG_SRCURL=https://github.com/webmproject/libvpx/archive/v${MININIX_PKG_VERSION}.tar.gz

mininix_step_configure () {
	# Force fresh install of header files:
	rm -Rf $MININIX_PREFIX/include/vpx

	export LD=$CC

	if [ $MININIX_ARCH = "arm" ]; then
		export AS=$MININIX_HOST_PLATFORM-as
		_CONFIGURE_TARGET="--target=armv7-android-gcc"
	elif [ $MININIX_ARCH = "i686" ]; then
		export AS=yasm
		_CONFIGURE_TARGET="--target=x86-android-gcc"
	elif [ $MININIX_ARCH = "aarch64" ]; then
		_CONFIGURE_TARGET="--force-target=arm64-v8a-android-gcc"
	elif [ $MININIX_ARCH = "x86_64" ]; then
		export AS=yasm
		_CONFIGURE_TARGET="--target=x86_64-android-gcc"
	else
		mininix_error_exit "Unsupported arch: $MININIX_ARCH"
	fi

	# For --disable-realtime-only, see
	# https://bugs.chromium.org/p/webm/issues/detail?id=800
	# "The issue is that on android we soft enable realtime only.
	#  [..] You can enable non-realtime by setting --disable-realtime-only"
	# Discovered in https://github.com/mininix/mininix-packages/issues/554
	#CROSS=${MININIX_HOST_PLATFORM}- CC=clang CXX=clang++ $MININIX_PKG_SRCDIR/configure \
	$MININIX_PKG_SRCDIR/configure \
		$_CONFIGURE_TARGET \
		--prefix=$MININIX_PREFIX \
		--disable-examples \
		--disable-realtime-only \
		--disable-unit-tests \
		--enable-pic \
		--enable-vp8 \
		--enable-shared \
		--enable-small
}
