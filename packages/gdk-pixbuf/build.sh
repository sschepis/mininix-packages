MININIX_PKG_HOMEPAGE=https://developer.gnome.org/gdk-pixbuf/
MININIX_PKG_DESCRIPTION="Library for image loading and manipulation"
MININIX_PKG_VERSION=2.36.12
MININIX_PKG_SHA256=fff85cf48223ab60e3c3c8318e2087131b590fd6f1737e42cb3759a3b427a334
MININIX_PKG_SRCURL=ftp://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${MININIX_PKG_VERSION:0:4}/gdk-pixbuf-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="glib, libpng, libtiff, libjpeg-turbo"
MININIX_PKG_DEVPACKAGE_DEPENDS="libpng-dev, glib-dev"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
gio_can_sniff=no
--disable-glibtest
"
