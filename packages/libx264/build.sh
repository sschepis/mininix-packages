LINUXDROID_PKG_HOMEPAGE=https://www.videolan.org/developers/x264.html
LINUXDROID_PKG_DESCRIPTION="Library for encoding video streams into the H.264/MPEG-4 AVC format"
LINUXDROID_PKG_VERSION=20180211
LINUXDROID_PKG_SHA256=cc9eaecaa7acc450120330979a53dbf8479c21ce7f4ab1aecc245d42384894bd
LINUXDROID_PKG_SRCURL=http://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${LINUXDROID_PKG_VERSION}-2245-stable.tar.bz2
# Avoid linking against ffmpeg libraries to avoid circular dependency:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-swscale
--disable-lavf"

linuxdroid_step_pre_configure () {
	#if [ $LINUXDROID_ARCH = "i686" -o $LINUXDROID_ARCH = "x86_64" ]; then
	if [ $LINUXDROID_ARCH = "i686" ]; then
		# Avoid text relocations on i686, see:
		# https://mailman.videolan.org/pipermail/x264-devel/2016-March/011589.html
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
		# Avoid errors such as "relocation R_386_GOTOFF against preemptible symbol
		# x264_significant_coeff_flag_offset cannot be used when making a shared object":
		LDFLAGS+=" -fuse-ld=bfd"
	elif [ $LINUXDROID_ARCH = "x86_64" ]; then
		# Avoid requiring nasm for now:
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}
