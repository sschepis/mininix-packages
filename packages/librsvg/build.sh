MININIX_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/LibRsvg
MININIX_PKG_DESCRIPTION="Library to render SVG files using cairo"
MININIX_PKG_VERSION=2.45.0
MININIX_PKG_SHA256=47bed5e2f802985383210f2b7596a8b20f5124a6d86423f5429e3d56a348f277
MININIX_PKG_SRCURL=http://ftp.gnome.org/pub/GNOME/sources/librsvg/${MININIX_PKG_VERSION:0:4}/librsvg-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="libcroco,pango,gdk-pixbuf"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-introspection --disable-pixbuf-loader"

mininix_step_pre_configure() {
	mininix_setup_rust

	# See https://github.com/GNOME/librsvg/blob/master/COMPILING.md
	export RUST_TARGET=$CARGO_TARGET_NAME
}
