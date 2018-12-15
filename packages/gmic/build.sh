MININIX_PKG_HOMEPAGE=https://gmic.eu
MININIX_PKG_DESCRIPTION="Full-featured framework for image processing"
MININIX_PKG_VERSION=2.4.1
MININIX_PKG_SHA256=446b465d2ff7314add634115f6bffecd136ad96759eb92f76c03f231f44188d6
MININIX_PKG_SRCURL=https://gmic.eu/files/source/gmic_$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="graphicsmagick++, libcurl, fftw, libpng, libjpeg-turbo, libtiff"
MININIX_PKG_BUILD_DEPENDS="graphicsmagick-dev"
MININIX_PKG_NO_DEVELSPLIT=yes
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_configure() {
	return 0;
}

mininix_step_make () {
	cd src/
	make cli
}

mininix_step_make_install() {
	cp src/gmic $MININIX_PREFIX/bin/gmic
	cp src/*.h $MININIX_PREFIX/include/
	gunzip man/gmic.1.gz
	cp man/gmic.1 $MININIX_PREFIX/share/man/man1
}

