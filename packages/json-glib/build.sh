MININIX_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/JsonGlib
MININIX_PKG_DESCRIPTION="GLib JSON manipulation library"
MININIX_PKG_VERSION=1.4.4
MININIX_PKG_SHA256=720c5f4379513dc11fd97dc75336eb0c0d3338c53128044d9fabec4374f4bc47
MININIX_PKG_SRCURL=https://download.gnome.org/sources/json-glib/${MININIX_PKG_VERSION:0:3}/json-glib-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="glib"
MININIX_PKG_DEVPACKAGE_DEPENDS="glib-dev"
MININIX_PKG_RM_AFTER_INSTALL="
share/installed-tests
libexec/installed-tests
bin/
"

mininix_step_pre_configure() {
	# Remove configure wrapper around meson build which prevents
	# meson setup in mininix_step_configure.
	rm configure
}
