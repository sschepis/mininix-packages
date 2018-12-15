MININIX_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/libsoup
MININIX_PKG_DESCRIPTION="HTTP client and server library"
MININIX_PKG_VERSION=2.62.3
MININIX_PKG_SHA256=d312ade547495c2093ff8bda61f9b9727a98cfdae339f3263277dd39c0451172
MININIX_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/libsoup/${MININIX_PKG_VERSION:0:4}/libsoup-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-vala --without-gssapi"
MININIX_PKG_DEPENDS="glib, libsqlite, libxml2"
