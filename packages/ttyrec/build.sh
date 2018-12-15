MININIX_PKG_HOMEPAGE=http://0xcc.net/ttyrec/
MININIX_PKG_DESCRIPTION="Terminal recorder and player"
MININIX_PKG_VERSION=1.0.8
MININIX_PKG_REVISION=3
MININIX_PKG_SRCURL=http://0xcc.net/ttyrec/ttyrec-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=ef5e9bf276b65bb831f9c2554cd8784bd5b4ee65353808f82b7e2aef851587ec
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	CFLAGS+=" -Dset_progname=setprogname"
}

mininix_step_make_install () {
	cp ttyrec ttyplay ttytime $MININIX_PREFIX/bin
	mkdir -p $MININIX_PREFIX/share/man/man1
	cp ttyrec.1 ttyplay.1 ttytime.1 $MININIX_PREFIX/share/man/man1
}
