LINUXDROID_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/JsonGlib
LINUXDROID_PKG_DESCRIPTION="GLib JSON manipulation library"
LINUXDROID_PKG_VERSION=1.4.4
LINUXDROID_PKG_SHA256=720c5f4379513dc11fd97dc75336eb0c0d3338c53128044d9fabec4374f4bc47
LINUXDROID_PKG_SRCURL=https://download.gnome.org/sources/json-glib/${LINUXDROID_PKG_VERSION:0:3}/json-glib-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="glib"
LINUXDROID_PKG_DEVPACKAGE_DEPENDS="glib-dev"
LINUXDROID_PKG_RM_AFTER_INSTALL="
share/installed-tests
libexec/installed-tests
bin/
"

linuxdroid_step_pre_configure() {
	# Remove configure wrapper around meson build which prevents
	# meson setup in linuxdroid_step_configure.
	rm configure
}
