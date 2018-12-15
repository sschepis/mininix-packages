MININIX_PKG_HOMEPAGE=http://michael.dipperstein.com/crypt/
MININIX_PKG_DESCRIPTION="A crypt(3) implementation"
MININIX_PKG_VERSION=0.2
MININIX_PKG_REVISION=1
MININIX_PKG_DEPENDS="openssl"

mininix_step_make_install () {
	$CC $CFLAGS $CPPFLAGS $LDFLAGS -Wall -Wextra -fPIC -shared $MININIX_PKG_BUILDER_DIR/crypt3.c -lcrypto -o $MININIX_PREFIX/lib/libcrypt.so
	mkdir -p $MININIX_PREFIX/include/
	cp $MININIX_PKG_BUILDER_DIR/crypt.h $MININIX_PREFIX/include/
}
