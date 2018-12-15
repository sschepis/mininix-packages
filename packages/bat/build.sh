MININIX_PKG_HOMEPAGE=https://github.com/sharkdp/bat
MININIX_PKG_DESCRIPTION="A cat(1) clone with wings"
MININIX_PKG_VERSION=0.9.0
MININIX_PKG_SHA256=4ce9c118cf5da1159a882dea389f3c5737b5d98192e9a619b0fe8c1730341cc6
MININIX_PKG_SRCURL=https://github.com/sharkdp/bat/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_make_install() {
	mkdir -p $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_SRCDIR/doc/bat.1 $MININIX_PREFIX/share/man/man1/
}
