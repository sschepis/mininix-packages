MININIX_PKG_HOMEPAGE=https://github.com/google/zopfli
MININIX_PKG_DESCRIPTION="New zlib compatible compressor library"
MININIX_PKG_VERSION=1.0.2
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=4a570307c37172d894ec4ef93b6e8e3aacc401e78cbcc51cf85b212dbc379a55
MININIX_PKG_SRCURL=https://github.com/google/zopfli/archive/zopfli-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_make_install () {
	make zopflipng
	cp zopfli zopflipng $MININIX_PREFIX/bin/

	mkdir -p $MININIX_PREFIX/include/zopfli/
	cp $MININIX_PKG_SRCDIR/src/zopfli/*h $MININIX_PREFIX/include/zopfli/
}
