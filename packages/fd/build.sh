MININIX_PKG_HOMEPAGE=https://github.com/sharkdp/fd
MININIX_PKG_DESCRIPTION="Simple, fast and user-friendly alternative to find"
MININIX_PKG_VERSION=7.2.0
MININIX_PKG_SHA256=153d0ac821901d9843b501dd6ba00e82aa73e3d61c27b2150af7ebc1fb6dff67
MININIX_PKG_SRCURL=https://github.com/sharkdp/fd/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_make_install() {
	mkdir -p  $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_SRCDIR/doc/fd.1 $MININIX_PREFIX/share/man/man1/fd.1
}
