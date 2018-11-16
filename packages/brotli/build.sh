LINUXDROID_PKG_HOMEPAGE=https://github.com/google/brotli
LINUXDROID_PKG_DESCRIPTION="lossless compression algorithm and format (command line utility)"
LINUXDROID_PKG_VERSION=1.0.7
LINUXDROID_PKG_SHA256=4c61bfb0faca87219ea587326c467b95acb25555b53d1a421ffa3c8a9296ee2c
LINUXDROID_PKG_SRCURL=https://github.com/google/brotli/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_FORCE_CMAKE=yes

linuxdroid_step_post_make_install() {
	mkdir -p $LINUXDROID_PREFIX/share/man/man{1,3}
	cp $LINUXDROID_PKG_SRCDIR/docs/brotli.1 $LINUXDROID_PREFIX/share/man/man1/
	cp $LINUXDROID_PKG_SRCDIR/docs/*.3 $LINUXDROID_PREFIX/share/man/man3/
}
