LINUXDROID_PKG_HOMEPAGE=http://qpdf.sourceforge.net
LINUXDROID_PKG_DESCRIPTION="Content-Preserving PDF Transformation System"
LINUXDROID_PKG_VERSION=8.2.1
LINUXDROID_PKG_SHA256=f61319dbb44ca45f3a200bd59e8a86a906b61e2d223b104d9d2fbddcab9100ab
LINUXDROID_PKG_SRCURL=https://github.com/qpdf/qpdf/archive/release-qpdf-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libjpeg-turbo"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-random=/dev/urandom"
LINUXDROID_PKG_BUILD_IN_SRC=true

linuxdroid_step_pre_configure () {
	autoreconf -fi
}
