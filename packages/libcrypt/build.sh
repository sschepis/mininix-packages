LINUXDROID_PKG_HOMEPAGE=http://michael.dipperstein.com/crypt/
LINUXDROID_PKG_DESCRIPTION="A crypt(3) implementation"
LINUXDROID_PKG_VERSION=0.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_DEPENDS="openssl"

linuxdroid_step_make_install () {
	$CC $CFLAGS $CPPFLAGS $LDFLAGS -Wall -Wextra -fPIC -shared $LINUXDROID_PKG_BUILDER_DIR/crypt3.c -lcrypto -o $LINUXDROID_PREFIX/lib/libcrypt.so
	mkdir -p $LINUXDROID_PREFIX/include/
	cp $LINUXDROID_PKG_BUILDER_DIR/crypt.h $LINUXDROID_PREFIX/include/
}
