MININIX_PKG_HOMEPAGE=https://www.ghostscript.com/
MININIX_PKG_DESCRIPTION="Interpreter for the PostScript language and for PDF"
MININIX_PKG_VERSION=9.26
MININIX_PKG_SHA256=b0d4916b669a63ed861f563c4607cc1230949c53431ab0798db8e680fdacc777
MININIX_PKG_SRCURL=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${MININIX_PKG_VERSION//.}/ghostpdl-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, libtiff, libjpeg-turbo, libpng, libexpat, freetype, fontconfig, libidn, littlecms, openjpeg"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_lcms2__cmsCreateMutex=yes
CCAUX=gcc
--build=$MININIX_BUILD_TUPLE
--enable-little-endian
--with-arch_h=$MININIX_PKG_BUILDER_DIR/arch-${MININIX_ARCH}.h
--without-pcl
--without-x
--with-system-libtiff
"

mininix_step_post_extract_package () {
        rm -rdf $MININIX_PKG_SRCDIR/{jpeg,libpng,expat,jasper,freetype,lcms2,tiff,openjpeg}
}
