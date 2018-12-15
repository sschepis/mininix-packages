MININIX_PKG_HOMEPAGE=https://gstreamer.freedesktop.org/
MININIX_PKG_DESCRIPTION="GStreamer Ugly Plug-ins"
MININIX_PKG_VERSION=1.14.4
MININIX_PKG_SHA256=ac02d837f166c35ff6ce0738e281680d0b90052cfb1f0255dcf6aaca5f0f6d23
MININIX_PKG_SRCURL=https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="gst-plugins-base, libx264"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-examples
--disable-android_media
"
MININIX_PKG_RM_AFTER_INSTALL="share/gtk-doc/"
