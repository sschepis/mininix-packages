LINUXDROID_PKG_HOMEPAGE=http://gegl.org/
LINUXDROID_PKG_DESCRIPTION="Data flow based image processing framework"
LINUXDROID_PKG_VERSION=0.4.12
LINUXDROID_PKG_SHA256=e967293eabe89257e1d511bf68435fbfd44e6e0f9ef51b86cc50781f09eb5852
LINUXDROID_PKG_SRCURL=https://download.gimp.org/pub/gegl/${LINUXDROID_PKG_VERSION:0:3}/gegl-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="libandroid-support, ffmpeg, babl, json-glib, libjpeg-turbo, libpng, libjasper, littlecms, libtiff, librsvg"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--without-gdk-pixbuf
"
