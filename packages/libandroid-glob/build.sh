LINUXDROID_PKG_HOMEPAGE=http://man7.org/linux/man-pages/man3/glob.3.html
LINUXDROID_PKG_DESCRIPTION="Shared library for the glob(3) system function"
LINUXDROID_PKG_VERSION=0.4
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make_install () {
	cp $LINUXDROID_PKG_BUILDER_DIR/glob.h $LINUXDROID_PREFIX/include/
	$CC $CFLAGS $CPPFLAGS $LDFLAGS $LINUXDROID_PKG_BUILDER_DIR/glob.c -shared -o $LINUXDROID_PREFIX/lib/libandroid-glob.so
}
