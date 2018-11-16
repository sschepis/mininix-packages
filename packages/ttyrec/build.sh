LINUXDROID_PKG_HOMEPAGE=http://0xcc.net/ttyrec/
LINUXDROID_PKG_DESCRIPTION="Terminal recorder and player"
LINUXDROID_PKG_VERSION=1.0.8
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_SRCURL=http://0xcc.net/ttyrec/ttyrec-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=ef5e9bf276b65bb831f9c2554cd8784bd5b4ee65353808f82b7e2aef851587ec
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	CFLAGS+=" -Dset_progname=setprogname"
}

linuxdroid_step_make_install () {
	cp ttyrec ttyplay ttytime $LINUXDROID_PREFIX/bin
	mkdir -p $LINUXDROID_PREFIX/share/man/man1
	cp ttyrec.1 ttyplay.1 ttytime.1 $LINUXDROID_PREFIX/share/man/man1
}
