LINUXDROID_PKG_HOMEPAGE=https://refspecs.linuxbase.org/LSB_2.1.0/LSB-generic/LSB-generic/libutil.html
LINUXDROID_PKG_DESCRIPTION="Library with terminal functions"
LINUXDROID_PKG_VERSION=0.3
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make_install () {
	CPPFLAGS+=" -std=c11 -Wall -Werror"
	$CC $CPPFLAGS $CFLAGS -c -fPIC $LINUXDROID_PKG_BUILDER_DIR/pty.c -o pty.o
	$CC -shared -fPIC $LDFLAGS -o $LINUXDROID_PREFIX/lib/libutil.so pty.o
}
