MININIX_PKG_HOMEPAGE=http://man7.org/linux/man-pages/man3/glob.3.html
MININIX_PKG_DESCRIPTION="Shared library for the glob(3) system function"
MININIX_PKG_VERSION=0.4
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make_install () {
	cp $MININIX_PKG_BUILDER_DIR/glob.h $MININIX_PREFIX/include/
	$CC $CFLAGS $CPPFLAGS $LDFLAGS $MININIX_PKG_BUILDER_DIR/glob.c -shared -o $MININIX_PREFIX/lib/libandroid-glob.so
}
