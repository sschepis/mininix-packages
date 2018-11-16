LINUXDROID_PKG_HOMEPAGE=https://mpv.io/
LINUXDROID_PKG_DESCRIPTION="Command-line media player"
LINUXDROID_PKG_VERSION=0.29.1
LINUXDROID_PKG_SHA256=f9f9d461d1990f9728660b4ccb0e8cb5dce29ccaa6af567bec481b79291ca623
LINUXDROID_PKG_SRCURL=https://github.com/mpv-player/mpv/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="ffmpeg, openal-soft, libandroid-glob, libpulseaudio"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/icons share/applications"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

linuxdroid_step_make_install () {
	cd $LINUXDROID_PKG_SRCDIR

	./bootstrap.py

	./waf configure \
		--prefix=$LINUXDROID_PREFIX \
		--disable-gl \
		--disable-jpeg \
		--disable-lcms2 \
		--disable-libarchive \
		--disable-libass \
		--disable-lua \
		--enable-pulse \
		--enable-openal \
		--disable-caca \
		--disable-alsa \
		--disable-x11

	./waf -v install

	# Use opensles audio out be default:
	mkdir -p $LINUXDROID_PREFIX/etc/mpv
	cp $LINUXDROID_PKG_BUILDER_DIR/mpv.conf $LINUXDROID_PREFIX/etc/mpv/mpv.conf

	# Try to work around OpenSL ES library clashes:
	# Linking against libOpenSLES causes indirect linkage against
	# libskia.so, which links against the platform libjpeg.so and
	# libpng.so, which are not compatible with the Linuxdroid ones.
	#
	# On Android N also liblzma seems to conflict.
	mkdir -p $LINUXDROID_PREFIX/libexec
	mv $LINUXDROID_PREFIX/bin/mpv $LINUXDROID_PREFIX/libexec

	local SYSTEM_LIBFOLDER=lib64
	if [ $LINUXDROID_ARCH_BITS = 32 ]; then SYSTEM_LIBFOLDER=lib; fi

	echo "#!/bin/sh" > $LINUXDROID_PREFIX/bin/mpv

	# Work around issues on devices having ffmpeg libraries
	# in a system vendor dir, reported by live_the_dream on #linuxdroid:
	local FFMPEG_LIBS="" lib
	for lib in avcodec avfilter avformat avutil postproc swresample swscale; do
		if [ -n "$FFMPEG_LIBS" ]; then FFMPEG_LIBS+=":"; fi
		FFMPEG_LIBS+="$LINUXDROID_PREFIX/lib/lib${lib}.so"
	done
	echo "export LD_PRELOAD=$FFMPEG_LIBS" >> $LINUXDROID_PREFIX/bin/mpv

	# /system/vendor/lib(64) needed for libqc-opt.so on
	# a xperia z5 c, reported by BrainDamage on #linuxdroid:
	echo "LD_LIBRARY_PATH=/system/$SYSTEM_LIBFOLDER:/system/vendor/$SYSTEM_LIBFOLDER:$LINUXDROID_PREFIX/lib exec $LINUXDROID_PREFIX/libexec/mpv \"\$@\"" >> $LINUXDROID_PREFIX/bin/mpv

	chmod +x $LINUXDROID_PREFIX/bin/mpv
}
