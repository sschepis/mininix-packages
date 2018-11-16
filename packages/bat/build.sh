LINUXDROID_PKG_HOMEPAGE=https://github.com/sharkdp/bat
LINUXDROID_PKG_DESCRIPTION="A cat(1) clone with wings"
LINUXDROID_PKG_VERSION=0.9.0
LINUXDROID_PKG_SHA256=4ce9c118cf5da1159a882dea389f3c5737b5d98192e9a619b0fe8c1730341cc6
LINUXDROID_PKG_SRCURL=https://github.com/sharkdp/bat/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_make_install() {
	mkdir -p $LINUXDROID_PREFIX/share/man/man1
	cp $LINUXDROID_PKG_SRCDIR/doc/bat.1 $LINUXDROID_PREFIX/share/man/man1/
}
