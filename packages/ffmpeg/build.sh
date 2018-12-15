MININIX_PKG_HOMEPAGE=https://ffmpeg.org
MININIX_PKG_DESCRIPTION="Tools and libraries to manipulate a wide range of multimedia formats and protocols"
# NOTE: mpv has to be rebuilt and version bumped after updating ffmpeg.
MININIX_PKG_VERSION=4.1
MININIX_PKG_SHA256=a38ec4d026efb58506a99ad5cd23d5a9793b4bf415f2c4c2e9c1bb444acd1994
MININIX_PKG_SRCURL=https://www.ffmpeg.org/releases/ffmpeg-${MININIX_PKG_VERSION}.tar.xz
# libbz2 is used by matroska decoder:
# libvpx is the VP8 & VP9 video encoder for WebM, see
# https://trac.ffmpeg.org/wiki/Encode/VP8 and https://trac.ffmpeg.org/wiki/Encode/VP9
MININIX_PKG_DEPENDS="libbz2, libsoxr, libx264, libx265, xvidcore, libvorbis, libmp3lame, libopus, libvpx, libgnutls, libandroid-glob"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="share/ffmpeg/examples"
MININIX_PKG_CONFLICTS="libav"

mininix_step_configure () {
	cd $MININIX_PKG_BUILDDIR

	export ASFLAGS="-no-integrated-as"

	local _EXTRA_CONFIGURE_FLAGS=""
	if [ $MININIX_ARCH = "arm" ]; then
		_ARCH="armeabi-v7a"
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	elif [ $MININIX_ARCH = "i686" ]; then
		_ARCH="x86"
		# Specify --disable-asm to prevent text relocations on i686,
		# see https://trac.ffmpeg.org/ticket/4928
		_EXTRA_CONFIGURE_FLAGS="--disable-asm"
	elif [ $MININIX_ARCH = "x86_64" ]; then
		_ARCH="x86_64"
	elif [ $MININIX_ARCH = "aarch64" ]; then
		_ARCH=$MININIX_ARCH
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	else
		mininix_error_exit "Unsupported arch: $MININIX_ARCH"
	fi

	# --disable-lzma to avoid problem with shared library clashes, see
	# https://github.com/mininix/mininix-packages/issues/511
	# Only used for LZMA compression support for tiff decoder.
	$MININIX_PKG_SRCDIR/configure \
		--arch=${_ARCH} \
		--as=$AS \
		--cc=$CC \
		--cxx=$CXX \
		--cross-prefix=${MININIX_HOST_PLATFORM}- \
		--disable-avdevice \
		--disable-static \
		--disable-symver \
		--disable-lzma \
		--enable-cross-compile \
		--enable-gnutls \
		--enable-gpl \
		--enable-libmp3lame \
		--enable-libvorbis \
		--enable-libopus \
		--enable-libx264 \
		--enable-libx265 \
		--enable-libxvid \
		--enable-libvpx \
		--enable-shared \
		--enable-libsoxr \
		--prefix=$MININIX_PREFIX \
		--target-os=android \
		--extra-libs="-landroid-glob" \
		$_EXTRA_CONFIGURE_FLAGS
}

