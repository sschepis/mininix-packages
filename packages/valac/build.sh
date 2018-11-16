LINUXDROID_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Vala
LINUXDROID_PKG_DESCRIPTION="C# like language for the GObject system"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_DEPENDS="clang, glib-dev, pkg-config"
LINUXDROID_PKG_VERSION=0.40.8
LINUXDROID_PKG_SHA256=5c35e087a7054e9f0a514a0c1f1d0a0d7cf68d3e43c1dbeb840f9b0d815c0fa5
LINUXDROID_PKG_SRCURL=https://download.gnome.org/sources/vala/${LINUXDROID_PKG_VERSION:0:4}/vala-$LINUXDROID_PKG_VERSION.tar.xz

linuxdroid_step_post_make_install() {
	cd $LINUXDROID_PREFIX/lib
	ln -s -f vala-0.40/libvalaccodegen.so libvalaccodegen.so
}
