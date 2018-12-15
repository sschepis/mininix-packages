MININIX_PKG_HOMEPAGE=http://www.graphicsmagick.org/
MININIX_PKG_DESCRIPTION="Collection of image processing tools"
MININIX_PKG_VERSION=1.3.31
MININIX_PKG_SHA256=096bbb59d6f3abd32b562fc3b34ea90d88741dc5dd888731d61d17e100394278
# Bandwith limited on main ftp site, so it's asked to use sourceforge instead:
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${MININIX_PKG_VERSION}/GraphicsMagick-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="littlecms, libtiff, freetype, libjasper, libjpeg-turbo, libpng, libbz2, libxml2, liblzma"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ftime=no
--with-fontpath=/system/fonts
--without-webp
--without-x
"
MININIX_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"
