MININIX_PKG_HOMEPAGE=https://mpv.io/
MININIX_PKG_DESCRIPTION="Command-line media player"
MININIX_PKG_VERSION=0.29.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=f9f9d461d1990f9728660b4ccb0e8cb5dce29ccaa6af567bec481b79291ca623
MININIX_PKG_SRCURL=https://github.com/mpv-player/mpv/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="ffmpeg, openal-soft, libandroid-glob, libpulseaudio"
MININIX_PKG_RM_AFTER_INSTALL="share/icons share/applications"

mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

mininix_step_make_install () {
	cd $MININIX_PKG_SRCDIR

	./bootstrap.py

	./waf configure \
		--prefix=$MININIX_PREFIX \
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
	mkdir -p $MININIX_PREFIX/etc/mpv
	cp $MININIX_PKG_BUILDER_DIR/mpv.conf $MININIX_PREFIX/etc/mpv/mpv.conf

	# Try to work around OpenSL ES library clashes:
	# Linking against libOpenSLES causes indirect linkage against
	# libskia.so, which links against the platform libjpeg.so and
	# libpng.so, which are not compatible with the Mininix ones.
	#
	# On Android N also liblzma seems to conflict.
	mkdir -p $MININIX_PREFIX/libexec
	mv $MININIX_PREFIX/bin/mpv $MININIX_PREFIX/libexec

	local SYSTEM_LIBFOLDER=lib64
	if [ $MININIX_ARCH_BITS = 32 ]; then SYSTEM_LIBFOLDER=lib; fi

	echo "#!/bin/sh" > $MININIX_PREFIX/bin/mpv

	# Work around issues on devices having ffmpeg libraries
	# in a system vendor dir, reported by live_the_dream on #mininix:
	local FFMPEG_LIBS="" lib
	for lib in avcodec avfilter avformat avutil postproc swresample swscale; do
		if [ -n "$FFMPEG_LIBS" ]; then FFMPEG_LIBS+=":"; fi
		FFMPEG_LIBS+="$MININIX_PREFIX/lib/lib${lib}.so"
	done
	echo "export LD_PRELOAD=$FFMPEG_LIBS" >> $MININIX_PREFIX/bin/mpv

	# /system/vendor/lib(64) needed for libqc-opt.so on
	# a xperia z5 c, reported by BrainDamage on #mininix:
	echo "LD_LIBRARY_PATH=/system/$SYSTEM_LIBFOLDER:/system/vendor/$SYSTEM_LIBFOLDER:$MININIX_PREFIX/lib exec $MININIX_PREFIX/libexec/mpv \"\$@\"" >> $MININIX_PREFIX/bin/mpv

	chmod +x $MININIX_PREFIX/bin/mpv
}
