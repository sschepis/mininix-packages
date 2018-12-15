MININIX_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
MININIX_PKG_DESCRIPTION="GStreamer Bad Plug-ins"
MININIX_PKG_VERSION=1.14.4
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=910b4e0e2e897e8b6d06767af1779d70057c309f67292f485ff988d087aa0de5
MININIX_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="gst-plugins-base, libbz2, libcurl, libpng, librsvg, libssh2, libsndfile, libx264, libx265, littlecms, openal-soft, openjpeg"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-android_media
--disable-examples
--disable-rtmp
--disable-tests
--disable-zbar
--disable-webp
--with-hls-crypto=openssl
"
MININIX_PKG_RM_AFTER_INSTALL="share/gtk-doc/"

mininix_step_pre_configure() {
	export GNUSTL_LIBS="-lc"
	export GNUSTL_CFLAGS="-Oz"
}
