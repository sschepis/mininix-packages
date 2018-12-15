MININIX_PKG_HOMEPAGE=http://qpdf.sourceforge.net
MININIX_PKG_DESCRIPTION="Content-Preserving PDF Transformation System"
MININIX_PKG_VERSION=8.2.1
MININIX_PKG_SHA256=f61319dbb44ca45f3a200bd59e8a86a906b61e2d223b104d9d2fbddcab9100ab
MININIX_PKG_SRCURL=https://github.com/qpdf/qpdf/archive/release-qpdf-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libjpeg-turbo"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-random=/dev/urandom"
MININIX_PKG_BUILD_IN_SRC=true

mininix_step_pre_configure () {
	autoreconf -fi
}
