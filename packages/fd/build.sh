LINUXDROID_PKG_HOMEPAGE=https://github.com/sharkdp/fd
LINUXDROID_PKG_DESCRIPTION="Simple, fast and user-friendly alternative to find"
LINUXDROID_PKG_VERSION=7.2.0
LINUXDROID_PKG_SHA256=153d0ac821901d9843b501dd6ba00e82aa73e3d61c27b2150af7ebc1fb6dff67
LINUXDROID_PKG_SRCURL=https://github.com/sharkdp/fd/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_make_install() {
	mkdir -p  $LINUXDROID_PREFIX/share/man/man1
	cp $LINUXDROID_PKG_SRCDIR/doc/fd.1 $LINUXDROID_PREFIX/share/man/man1/fd.1
}
