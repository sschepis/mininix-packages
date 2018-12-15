MININIX_PKG_HOMEPAGE=http://optipng.sourceforge.net/
MININIX_PKG_DESCRIPTION="PNG optimizer that recompresses image files to a smaller size, without losing any information"
MININIX_PKG_VERSION=0.7.7
MININIX_PKG_SHA256=4f32f233cef870b3f95d3ad6428bfe4224ef34908f1b42b0badf858216654452
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-${MININIX_PKG_VERSION}/optipng-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libpng"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-system-zlib --with-system-libpng --mandir=$MININIX_PREFIX/share/man"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	LD=$CC
}
