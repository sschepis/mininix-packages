LINUXDROID_PKG_HOMEPAGE=http://www.graphicsmagick.org/
LINUXDROID_PKG_DESCRIPTION="Collection of image processing tools"
LINUXDROID_PKG_VERSION=1.3.30
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=d965e5c6559f55eec76c20231c095d4ae682ea0cbdd8453249ae8771405659f1
# Bandwith limited on main ftp site, so it's asked to use sourceforge instead:
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${LINUXDROID_PKG_VERSION}/GraphicsMagick-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="littlecms, libtiff, freetype, libjasper, libjpeg-turbo, libpng, libbz2, libxml2, liblzma"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ftime=no
--with-fontpath=/system/fonts
--without-webp
--without-x
"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"
