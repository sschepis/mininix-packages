LINUXDROID_PKG_HOMEPAGE=https://ffmpeg.org
LINUXDROID_PKG_DESCRIPTION="Tools and libraries to manipulate a wide range of multimedia formats and protocols"
# NOTE: mpv has to be rebuilt and version bumped after updating ffmpeg.
LINUXDROID_PKG_VERSION=4.0.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=a95c0cc9eb990e94031d2183f2e6e444cc61c99f6f182d1575c433d62afb2f97
LINUXDROID_PKG_SRCURL=https://www.ffmpeg.org/releases/ffmpeg-${LINUXDROID_PKG_VERSION}.tar.xz
# libbz2 is used by matroska decoder:
# libvpx is the VP8 & VP9 video encoder for WebM, see
# https://trac.ffmpeg.org/wiki/Encode/VP8 and https://trac.ffmpeg.org/wiki/Encode/VP9
LINUXDROID_PKG_DEPENDS="libbz2, libsoxr, libx264, libx265, xvidcore, libvorbis, libmp3lame, libopus, libvpx, libgnutls, libandroid-glob"
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="share/ffmpeg/examples"
LINUXDROID_PKG_CONFLICTS="libav"

linuxdroid_step_configure () {
	cd $LINUXDROID_PKG_BUILDDIR

	export ASFLAGS="-no-integrated-as"

	local _EXTRA_CONFIGURE_FLAGS=""
	if [ $LINUXDROID_ARCH = "arm" ]; then
		_ARCH="armeabi-v7a"
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	elif [ $LINUXDROID_ARCH = "i686" ]; then
		_ARCH="x86"
		# Specify --disable-asm to prevent text relocations on i686,
		# see https://trac.ffmpeg.org/ticket/4928
		_EXTRA_CONFIGURE_FLAGS="--disable-asm"
	elif [ $LINUXDROID_ARCH = "x86_64" ]; then
		_ARCH="x86_64"
	elif [ $LINUXDROID_ARCH = "aarch64" ]; then
		_ARCH=$LINUXDROID_ARCH
		_EXTRA_CONFIGURE_FLAGS="--enable-neon"
	else
		linuxdroid_error_exit "Unsupported arch: $LINUXDROID_ARCH"
	fi

	# --disable-lzma to avoid problem with shared library clashes, see
	# https://github.com/linuxdroid/linuxdroid-packages/issues/511
	# Only used for LZMA compression support for tiff decoder.
	$LINUXDROID_PKG_SRCDIR/configure \
		--arch=${_ARCH} \
		--as=$AS \
		--cc=$CC \
		--cxx=$CXX \
		--cross-prefix=${LINUXDROID_HOST_PLATFORM}- \
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
		--prefix=$LINUXDROID_PREFIX \
		--target-os=android \
		--extra-libs="-landroid-glob" \
		$_EXTRA_CONFIGURE_FLAGS
}

