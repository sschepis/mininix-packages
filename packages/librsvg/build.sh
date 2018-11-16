LINUXDROID_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/LibRsvg
LINUXDROID_PKG_DESCRIPTION="Library to render SVG files using cairo"
LINUXDROID_PKG_VERSION=2.40.20
LINUXDROID_PKG_SHA256=cff4dd3c3b78bfe99d8fcfad3b8ba1eee3289a0823c0e118d78106be6b84c92b
LINUXDROID_PKG_SRCURL=http://ftp.gnome.org/pub/GNOME/sources/librsvg/2.40/librsvg-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="libcroco,pango,gdk-pixbuf"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-introspection --disable-pixbuf-loader"
