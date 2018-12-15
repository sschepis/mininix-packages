MININIX_PKG_HOMEPAGE=https://github.com/mauke/unibilium
MININIX_PKG_DESCRIPTION="Terminfo parsing library"
MININIX_PKG_VERSION=2.0.0
MININIX_PKG_SHA256=78997d38d4c8177c60d3d0c1aa8c53fd0806eb21825b7b335b1768d7116bc1c1
MININIX_PKG_SRCURL=https://github.com/mauke/unibilium/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make () {
	return
}

mininix_step_make_install () {
	CFLAGS+=" -DTERMINFO_DIRS=\"$MININIX_PREFIX/share/terminfo/\""
	$CC $CFLAGS -c -fPIC unibilium.c -o unibilium.o
	$CC $CFLAGS -c -fPIC uninames.c -o uninames.o
	$CC $CFLAGS -c -fPIC uniutil.c -o uniutil.o
	$CC -shared -fPIC $LDFLAGS -o $MININIX_PREFIX/lib/libunibilium.so unibilium.o uninames.o uniutil.o
	cp unibilium.h $MININIX_PREFIX/include/
}
