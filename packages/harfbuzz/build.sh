LINUXDROID_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/HarfBuzz/
LINUXDROID_PKG_DESCRIPTION="OpenType text shaping engine"
LINUXDROID_PKG_VERSION=2.1.1
LINUXDROID_PKG_SHA256=83bf5d552df72c52969332f294cd97d8f6b46b77b41b61346ca56ebb81884e14
LINUXDROID_PKG_SRCURL=https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="freetype,glib,libbz2,libpng,libgraphite"
LINUXDROID_PKG_BUILD_DEPENDS="libicu"
LINUXDROID_PKG_DEVPACKAGE_DEPENDS="libgraphite-dev"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-icu=yes --with-graphite2=yes --disable-gtk-doc-html"
