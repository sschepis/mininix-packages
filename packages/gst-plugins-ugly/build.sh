LINUXDROID_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
LINUXDROID_PKG_DESCRIPTION="GStreamer Ugly Plug-ins"
LINUXDROID_PKG_VERSION=1.14.4
LINUXDROID_PKG_SHA256=ac02d837f166c35ff6ce0738e281680d0b90052cfb1f0255dcf6aaca5f0f6d23
LINUXDROID_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="gst-plugins-base, libx264"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-examples
--disable-android_media
"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/gtk-doc/"
