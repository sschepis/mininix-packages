LINUXDROID_PKG_HOMEPAGE=https://www.ghostscript.com/
LINUXDROID_PKG_DESCRIPTION="Interpreter for the PostScript language and for PDF"
LINUXDROID_PKG_VERSION=9.25
LINUXDROID_PKG_SHA256=784531e81f144c0f703a0f079e6fd1522eabb97b3a0670a92bdd1f39bf201d99
LINUXDROID_PKG_SRCURL=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${LINUXDROID_PKG_VERSION//.}/ghostpdl-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, libtiff, libjpeg-turbo, libpng, libexpat, freetype, fontconfig, libidn, littlecms, openjpeg"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_lcms2__cmsCreateMutex=yes
CCAUX=gcc
--build=$LINUXDROID_BUILD_TUPLE
--enable-little-endian
--with-arch_h=$LINUXDROID_PKG_BUILDER_DIR/arch-${LINUXDROID_ARCH}.h
--without-pcl
--without-x
--with-system-libtiff
"

linuxdroid_step_post_extract_package () {
        rm -rdf $LINUXDROID_PKG_SRCDIR/{jpeg,libpng,expat,jasper,freetype,lcms2,tiff,openjpeg}
}
