LINUXDROID_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
LINUXDROID_PKG_DESCRIPTION="Library for configuring and customizing font access"
LINUXDROID_PKG_VERSION=2.13.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=f655dd2a986d7aa97e052261b36aa67b0a64989496361eca8d604e6414006741
LINUXDROID_PKG_SRCURL=https://www.freedesktop.org/software/fontconfig/release/fontconfig-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="freetype, libxml2, libpng, libuuid"
LINUXDROID_PKG_DEVPACKAGE_DEPENDS="freetype-dev, libxml2-dev"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libxml2
--enable-iconv=no
--disable-docs
--with-default-fonts=/system/fonts
--with-add-fonts=$LINUXDROID_PREFIX/share/fonts
"
