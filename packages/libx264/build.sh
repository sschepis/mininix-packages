MININIX_PKG_HOMEPAGE=https://www.videolan.org/developers/x264.html
MININIX_PKG_DESCRIPTION="Library for encoding video streams into the H.264/MPEG-4 AVC format"
MININIX_PKG_VERSION=20180211
MININIX_PKG_SHA256=cc9eaecaa7acc450120330979a53dbf8479c21ce7f4ab1aecc245d42384894bd
MININIX_PKG_SRCURL=http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${MININIX_PKG_VERSION}-2245-stable.tar.bz2
# Avoid linking against ffmpeg libraries to avoid circular dependency:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-swscale
--disable-lavf"

mininix_step_pre_configure () {
	#if [ $MININIX_ARCH = "i686" -o $MININIX_ARCH = "x86_64" ]; then
	if [ $MININIX_ARCH = "i686" ]; then
		# Avoid text relocations on i686, see:
		# https://mailman.videolan.org/pipermail/x264-devel/2016-March/011589.html
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
		# Avoid errors such as "relocation R_386_GOTOFF against preemptible symbol
		# x264_significant_coeff_flag_offset cannot be used when making a shared object":
		LDFLAGS+=" -fuse-ld=bfd"
	elif [ $MININIX_ARCH = "x86_64" ]; then
		# Avoid requiring nasm for now:
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}
