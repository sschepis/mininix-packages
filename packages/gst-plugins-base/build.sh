LINUXDROID_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
LINUXDROID_PKG_DESCRIPTION="GStreamer base plug-ins"
LINUXDROID_PKG_VERSION=1.14.4
LINUXDROID_PKG_SHA256=ca6139490e48863e7706d870ff4e8ac9f417b56f3b9e4b3ce490c13b09a77461
LINUXDROID_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="gstreamer, libjpeg-turbo, libopus, libpng, libvorbis"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-examples
--disable-pango
"

linuxdroid_step_post_make_install () {
	for BINARY in gst-play-1.0 gst-discoverer-1.0 gst-device-monitor-1.0
	    do	
		echo $BINARY
		local LIBEXEC_BINARY=$LINUXDROID_PREFIX/libexec/$BINARY
		local BIN_BINARY=$LINUXDROID_PREFIX/bin/$BINARY
		local LIB_PATH=/system/lib
		local VENDOR_LIB_PATH=/system/vendor/lib
		if [ ! "$LINUXDROID_ARCH_BITS" == "32" ]
		then
			LIB_PATH+=64
			VENDOR_LIB_PATH+=64
		fi
			
		mv $BIN_BINARY $LIBEXEC_BINARY
		local FFMPEG_LIBS="" lib
        for lib in avcodec avfilter avformat avutil postproc swresample swscale; do
                if [ -n "$FFMPEG_LIBS" ]; then FFMPEG_LIBS+=":"; fi
                FFMPEG_LIBS+="$LINUXDROID_PREFIX/lib/lib${lib}.so"
        done

		cat << EOF > $BIN_BINARY
#!/bin/sh
export LD_PRELOAD=$FFMPEG_LIBS
# Avoid linker errors due to libOpenSLES.so:
LD_LIBRARY_PATH=$LIB_PATH:$VENDOR_LIB_PATH:$LINUXDROID_PREFIX/lib exec $LIBEXEC_BINARY "\$@"
EOF
		chmod +x $BIN_BINARY
	done
}
