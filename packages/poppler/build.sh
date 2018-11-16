LINUXDROID_PKG_HOMEPAGE=https://poppler.freedesktop.org/
LINUXDROID_PKG_DESCRIPTION="PDF rendering library"
LINUXDROID_PKG_VERSION=0.67.0
LINUXDROID_PKG_SHA256=a34a4f1a0f5b610c584c65824e92e3ba3e08a89d8ab4622aee11b8ceea5366f9
LINUXDROID_PKG_SRCURL=https://poppler.freedesktop.org/poppler-${LINUXDROID_PKG_VERSION}.tar.xz
# libcairo and littlecms is used by pdftocairo:
LINUXDROID_PKG_DEPENDS="fontconfig, libcairo, libpng, libjpeg-turbo, libtiff, littlecms, openjpeg, freetype, libcurl"
#texlive needs the xpdf headers
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GLIB=OFF
-DENABLE_XPDF_HEADERS=ON
-DENABLE_QT5=OFF
-DFONT_CONFIGURATION=fontconfig
"
