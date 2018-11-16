LINUXDROID_PKG_HOMEPAGE=http://libvterm.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="Terminal emulator library"
# libvterm does not do releases, take a specific commit for now:
LINUXDROID_PKG_VERSION=18.02.20
_COMMIT=005845cd58ca409a970d822b74e1a02a503d32e7
LINUXDROID_PKG_SHA256=2424ee587bc13910894ade21ba75649d558b8c161fa1eb5ed69802ecca47b516
LINUXDROID_PKG_SRCURL=https://github.com/neovim/libvterm/archive/$_COMMIT.zip
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make () {
	make src/encoding/DECdrawing.inc src/encoding/uk.inc
}

linuxdroid_step_make_install () {
	cd $LINUXDROID_PKG_SRCDIR/src
	$CC -std=c99 -shared -fPIC $LDFLAGS -o $LINUXDROID_PREFIX/lib/libvterm.so *.c -I../include -I.
	cp ../include/*.h $LINUXDROID_PREFIX/include/
}
