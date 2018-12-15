MININIX_PKG_HOMEPAGE=https://cairographics.org
MININIX_PKG_DESCRIPTION="Cairo 2D vector graphics library"
MININIX_PKG_VERSION=1.16.0
MININIX_PKG_SHA256=5e7b29b3f113ef870d1e3ecf8adf21f923396401604bda16d44be45e66052331
MININIX_PKG_SRCURL=https://cairographics.org/releases/cairo-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="libandroid-support, libpixman, fontconfig, freetype, libpng"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_lzo2_lzo2a_decompress=no
--disable-gtk-doc-html
--enable-xlib=no
--enable-xcb=no
"
MININIX_PKG_RM_AFTER_INSTALL="share/gtk-doc/html"
