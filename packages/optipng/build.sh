LINUXDROID_PKG_HOMEPAGE=http://optipng.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="PNG optimizer that recompresses image files to a smaller size, without losing any information"
LINUXDROID_PKG_VERSION=0.7.7
LINUXDROID_PKG_SHA256=4f32f233cef870b3f95d3ad6428bfe4224ef34908f1b42b0badf858216654452
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-${LINUXDROID_PKG_VERSION}/optipng-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libpng"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-system-zlib --with-system-libpng --mandir=$LINUXDROID_PREFIX/share/man"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	LD=$CC
}
