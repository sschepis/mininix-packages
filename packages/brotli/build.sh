MININIX_PKG_HOMEPAGE=https://github.com/google/brotli
MININIX_PKG_DESCRIPTION="lossless compression algorithm and format (command line utility)"
MININIX_PKG_VERSION=1.0.7
MININIX_PKG_SHA256=4c61bfb0faca87219ea587326c467b95acb25555b53d1a421ffa3c8a9296ee2c
MININIX_PKG_SRCURL=https://github.com/google/brotli/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_FORCE_CMAKE=yes

mininix_step_post_make_install() {
	mkdir -p $MININIX_PREFIX/share/man/man{1,3}
	cp $MININIX_PKG_SRCDIR/docs/brotli.1 $MININIX_PREFIX/share/man/man1/
	cp $MININIX_PKG_SRCDIR/docs/*.3 $MININIX_PREFIX/share/man/man3/
}
