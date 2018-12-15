MININIX_PKG_HOMEPAGE=http://gegl.org/
MININIX_PKG_DESCRIPTION="Data flow based image processing framework"
MININIX_PKG_VERSION=0.4.12
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=e967293eabe89257e1d511bf68435fbfd44e6e0f9ef51b86cc50781f09eb5852
MININIX_PKG_SRCURL=https://download.gimp.org/pub/gegl/${MININIX_PKG_VERSION:0:3}/gegl-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="libandroid-support, ffmpeg, babl, json-glib, libjpeg-turbo, libpng, libjasper, littlecms, libtiff, librsvg"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--without-gdk-pixbuf
"
