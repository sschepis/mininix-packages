MININIX_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Vala
MININIX_PKG_DESCRIPTION="C# like language for the GObject system"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_DEPENDS="clang, glib-dev, pkg-config"
MININIX_PKG_VERSION=0.40.8
MININIX_PKG_SHA256=5c35e087a7054e9f0a514a0c1f1d0a0d7cf68d3e43c1dbeb840f9b0d815c0fa5
MININIX_PKG_SRCURL=https://download.gnome.org/sources/vala/${MININIX_PKG_VERSION:0:4}/vala-$MININIX_PKG_VERSION.tar.xz

mininix_step_post_make_install() {
	cd $MININIX_PREFIX/lib
	ln -s -f vala-0.40/libvalaccodegen.so libvalaccodegen.so
}
