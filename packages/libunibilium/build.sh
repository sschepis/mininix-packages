LINUXDROID_PKG_HOMEPAGE=https://github.com/mauke/unibilium
LINUXDROID_PKG_DESCRIPTION="Terminfo parsing library"
LINUXDROID_PKG_VERSION=2.0.0
LINUXDROID_PKG_SHA256=78997d38d4c8177c60d3d0c1aa8c53fd0806eb21825b7b335b1768d7116bc1c1
LINUXDROID_PKG_SRCURL=https://github.com/mauke/unibilium/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make () {
	return
}

linuxdroid_step_make_install () {
	CFLAGS+=" -DTERMINFO_DIRS=\"$LINUXDROID_PREFIX/share/terminfo/\""
	$CC $CFLAGS -c -fPIC unibilium.c -o unibilium.o
	$CC $CFLAGS -c -fPIC uninames.c -o uninames.o
	$CC $CFLAGS -c -fPIC uniutil.c -o uniutil.o
	$CC -shared -fPIC $LDFLAGS -o $LINUXDROID_PREFIX/lib/libunibilium.so unibilium.o uninames.o uniutil.o
	cp unibilium.h $LINUXDROID_PREFIX/include/
}
