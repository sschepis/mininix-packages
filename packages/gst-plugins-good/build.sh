MININIX_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
MININIX_PKG_DESCRIPTION="GStreamer Good Plug-ins"
MININIX_PKG_VERSION=1.14.4
MININIX_PKG_SHA256=5f8b553260cb0aac56890053d8511db1528d53cae10f0287cfce2cb2acc70979
MININIX_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="gst-plugins-base,libcaca,libsoup,libjpeg-turbo,libpng,libflac,libbz2,libvpx,libpulseaudio,libmp3lame"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-android_media
--disable-cairo
--disable-examples
--disable-gdk_pixbuf
--disable-oss
--disable-oss4
--disable-tests
--disable-gst_v4l2
"
MININIX_PKG_RM_AFTER_INSTALL="share/gtk-doc/"
