LINUXDROID_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
LINUXDROID_PKG_DESCRIPTION="GStreamer Bad Plug-ins"
LINUXDROID_PKG_VERSION=1.14.4
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=910b4e0e2e897e8b6d06767af1779d70057c309f67292f485ff988d087aa0de5
LINUXDROID_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="gst-plugins-base, libbz2, libcurl, libpng, librsvg, libssh2, libsndfile, libx264, libx265, littlecms, openal-soft, openjpeg"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-android_media
--disable-examples
--disable-rtmp
--disable-tests
--disable-zbar
--disable-webp
--with-hls-crypto=openssl
"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/gtk-doc/"

linuxdroid_step_pre_configure() {
	export GNUSTL_LIBS="-lc"
	export GNUSTL_CFLAGS="-Oz"
}
