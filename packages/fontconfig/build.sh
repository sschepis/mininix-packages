MININIX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
MININIX_PKG_DESCRIPTION="Library for configuring and customizing font access"
MININIX_PKG_VERSION=2.13.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=f655dd2a986d7aa97e052261b36aa67b0a64989496361eca8d604e6414006741
MININIX_PKG_SRCURL=https://www.freedesktop.org/software/fontconfig/release/fontconfig-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="freetype, libxml2, libpng, libuuid"
MININIX_PKG_DEVPACKAGE_DEPENDS="freetype-dev, libxml2-dev"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libxml2
--enable-iconv=no
--disable-docs
--with-default-fonts=/system/fonts
--with-add-fonts=$MININIX_PREFIX/share/fonts
"
