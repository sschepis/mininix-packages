MININIX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/HarfBuzz/
MININIX_PKG_DESCRIPTION="OpenType text shaping engine"
MININIX_PKG_VERSION=2.1.3
MININIX_PKG_SHA256=613264460bb6814c3894e3953225c5357402915853a652d40b4230ce5faf0bee
MININIX_PKG_SRCURL=https://www.freedesktop.org/software/harfbuzz/release/harfbuzz-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="freetype,glib,libbz2,libpng,libgraphite"
MININIX_PKG_BUILD_DEPENDS="libicu"
MININIX_PKG_DEVPACKAGE_DEPENDS="libgraphite-dev"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-icu=yes --with-graphite2=yes --disable-gtk-doc-html"
