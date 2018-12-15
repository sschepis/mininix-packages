MININIX_PKG_HOMEPAGE=https://refspecs.linuxbase.org/LSB_2.1.0/LSB-generic/LSB-generic/libutil.html
MININIX_PKG_DESCRIPTION="Library with terminal functions"
MININIX_PKG_VERSION=0.3
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make_install () {
	CPPFLAGS+=" -std=c11 -Wall -Werror"
	$CC $CPPFLAGS $CFLAGS -c -fPIC $MININIX_PKG_BUILDER_DIR/pty.c -o pty.o
	$CC -shared -fPIC $LDFLAGS -o $MININIX_PREFIX/lib/libutil.so pty.o
}
