LINUXDROID_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
LINUXDROID_PKG_DESCRIPTION="GStreamer Good Plug-ins"
LINUXDROID_PKG_VERSION=1.14.4
LINUXDROID_PKG_SHA256=5f8b553260cb0aac56890053d8511db1528d53cae10f0287cfce2cb2acc70979
LINUXDROID_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="gst-plugins-base,libcaca,libsoup,libjpeg-turbo,libpng,libflac,libbz2,libvpx,libpulseaudio,libmp3lame"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-android_media
--disable-cairo
--disable-examples
--disable-gdk_pixbuf
--disable-oss
--disable-oss4
--disable-tests
--disable-gst_v4l2
"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/gtk-doc/"
