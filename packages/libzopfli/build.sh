LINUXDROID_PKG_HOMEPAGE=https://github.com/google/zopfli
LINUXDROID_PKG_DESCRIPTION="New zlib compatible compressor library"
LINUXDROID_PKG_VERSION=1.0.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=4a570307c37172d894ec4ef93b6e8e3aacc401e78cbcc51cf85b212dbc379a55
LINUXDROID_PKG_SRCURL=https://github.com/google/zopfli/archive/zopfli-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_make_install () {
	make zopflipng
	cp zopfli zopflipng $LINUXDROID_PREFIX/bin/

	mkdir -p $LINUXDROID_PREFIX/include/zopfli/
	cp $LINUXDROID_PKG_SRCDIR/src/zopfli/*h $LINUXDROID_PREFIX/include/zopfli/
}
