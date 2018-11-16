LINUXDROID_PKG_HOMEPAGE=https://gmic.eu
LINUXDROID_PKG_DESCRIPTION="Full-featured framework for image processing"
LINUXDROID_PKG_VERSION=2.4.1
LINUXDROID_PKG_SHA256=446b465d2ff7314add634115f6bffecd136ad96759eb92f76c03f231f44188d6
LINUXDROID_PKG_SRCURL=https://gmic.eu/files/source/gmic_$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="graphicsmagick++, libcurl, fftw, libpng, libjpeg-turbo, libtiff"
LINUXDROID_PKG_BUILD_DEPENDS="graphicsmagick-dev"
LINUXDROID_PKG_NO_DEVELSPLIT=yes
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure() {
	return 0;
}

linuxdroid_step_make () {
	cd src/
	make cli
}

linuxdroid_step_make_install() {
	cp src/gmic $LINUXDROID_PREFIX/bin/gmic
	cp src/*.h $LINUXDROID_PREFIX/include/
	gunzip man/gmic.1.gz
	cp man/gmic.1 $LINUXDROID_PREFIX/share/man/man1
}

