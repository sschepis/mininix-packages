MININIX_PKG_HOMEPAGE=https://www.musicpd.org
MININIX_PKG_DESCRIPTION="Music player daemon"
MININIX_PKG_VERSION=0.20.23
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=93c4441719a8312f3d150de02b1db0c22fe3a1a99e4159c6056950846a109368
MININIX_PKG_SRCURL=https://github.com/MusicPlayerDaemon/MPD/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libcurl, libid3tag, libopus, libpulseaudio, libmpdclient, openal-soft, libvorbis, libsqlite, ffmpeg, libmp3lame, libbz2"
MININIX_PKG_BUILD_DEPENDS="boost"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-alsa
--disable-ao
--disable-epoll
--disable-expat
--disable-iconv
--disable-icu
--disable-mad
--disable-sndio
--without-tremor
ac_cv_func_linkat=no
"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_CONFFILES="$MININIX_PREFIX/etc/mpd.conf"

mininix_step_pre_configure() {
	CXXFLAGS+=" -DMININIX -UANDROID"
	LDFLAGS+=" -llog -lOpenSLES"
	NOCONFIGURE=1	./autogen.sh
	rm -f /data/data/com.mininix/files/usr/etc/mpd.conf
}

mininix_step_make_install () {
	# Try to work around OpenSL ES library clashes:
	# Linking against libOpenSLES causes indirect linkage against
	# libskia.so, which links against the platform libjpeg.so and
	# libpng.so, which are not compatible with the Mininix ones.
	#
	# On Android N also liblzma seems to conflict.
	make install
	cp -f $MININIX_PREFIX/share/doc/mpd/mpdconf.example /data/data/com.mininix/files/usr/etc/mpd.conf
	mkdir -p $MININIX_PREFIX/libexec
	mkdir -p $MININIX_PREFIX/var/mpd
	mv $MININIX_PREFIX/bin/mpd $MININIX_PREFIX/libexec
	local SYSTEM_LIBFOLDER=lib64
	if [ $MININIX_ARCH_BITS = 32 ]; then SYSTEM_LIBFOLDER=lib; fi

	echo "#!/bin/sh" > $MININIX_PREFIX/bin/mpd
	cat $MININIX_SCRIPTDIR/packages/mpd/mpd-script.sh >> $MININIX_PREFIX/bin/mpd
	# Work around issues on devices having ffmpeg libraries
	# in a system vendor dir, reported by live_the_dream on #mininix:
	local FFMPEG_LIBS="" lib
	# c++_shared needs to go first in every c++ app that uses audio directly.
	for lib in c++_shared curl ssl opus vorbis avcodec avfilter avformat avutil postproc swresample swscale sqlite3; do
		if [ -n "$FFMPEG_LIBS" ]; then FFMPEG_LIBS+=":"; fi
		FFMPEG_LIBS+="$MININIX_PREFIX/lib/lib${lib}.so"
	done
	echo "export LD_PRELOAD=$FFMPEG_LIBS" >> $MININIX_PREFIX/bin/mpd
	chmod +x $MININIX_PREFIX/bin/mpd
	# /system/vendor/lib(64) needed for libqc-opt.so on
	# a xperia z5 c, reported by BrainDamage on #mininix:
	echo "LD_LIBRARY_PATH=/system/$SYSTEM_LIBFOLDER:/system/vendor/$SYSTEM_LIBFOLDER:$MININIX_PREFIX/lib exec $MININIX_PREFIX/libexec/mpd \"\$@\"" >> $MININIX_PREFIX/bin/mpd
}

mininix_step_create_debscripts() {
	echo "#!$MININIX_PREFIX/bin/sh" > postinst
	echo 'mkdir -p $HOME/.mpd/playlists' >> postinst
}
