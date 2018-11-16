LINUXDROID_PKG_HOMEPAGE=https://developer.gnome.org/gdk-pixbuf/
LINUXDROID_PKG_DESCRIPTION="Library for image loading and manipulation"
LINUXDROID_PKG_VERSION=2.36.12
LINUXDROID_PKG_SHA256=fff85cf48223ab60e3c3c8318e2087131b590fd6f1737e42cb3759a3b427a334
LINUXDROID_PKG_SRCURL=ftp://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${LINUXDROID_PKG_VERSION:0:4}/gdk-pixbuf-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="glib, libpng, libtiff, libjpeg-turbo"
LINUXDROID_PKG_DEVPACKAGE_DEPENDS="libpng-dev, glib-dev"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
gio_can_sniff=no
--disable-glibtest
"
