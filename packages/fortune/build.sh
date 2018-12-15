MININIX_PKG_HOMEPAGE=https://www.fefe.de/fortune/
MININIX_PKG_DESCRIPTION="Revealer of fortunes"
MININIX_PKG_VERSION=1.2
MININIX_PKG_SRCURL=http://dl.fefe.de/fortune-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_SHA256=cbb246a500366db39ce035632eb4954e09f1e03b28f2c4688864bfa8661b236a

mininix_step_make_install () {
	cd $MININIX_PKG_SRCDIR
	$CC $CFLAGS fortune.c -o $MININIX_PREFIX/bin/fortune
	mkdir -p $MININIX_PREFIX/share/man/man6
	cp debian/fortune.6 $MININIX_PREFIX/share/man/man6/

	local TARFILE=$MININIX_PKG_CACHEDIR/f.tar.gz
	mininix_download \
		http://http.debian.net/debian/pool/main/f/fortune-mod/fortune-mod_1.99.1.orig.tar.gz \
		$TARFILE \
		fc51aee1f73c936c885f4e0f8b6b48f4f68103e3896eaddc6a45d2b71e14eace

	cd $MININIX_PKG_TMPDIR
	mkdir datfiles
	cd datfiles

	tar xf $TARFILE
	cd fortune-mod-1.99.1/datfiles

	rm -Rf html off Makefile
	mkdir -p $MININIX_PREFIX/share/games/fortunes
	cp * $MININIX_PREFIX/share/games/fortunes
}
