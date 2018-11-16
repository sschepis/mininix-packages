LINUXDROID_PKG_HOMEPAGE=https://www.fefe.de/fortune/
LINUXDROID_PKG_DESCRIPTION="Revealer of fortunes"
LINUXDROID_PKG_VERSION=1.2
LINUXDROID_PKG_SRCURL=http://dl.fefe.de/fortune-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=cbb246a500366db39ce035632eb4954e09f1e03b28f2c4688864bfa8661b236a

linuxdroid_step_make_install () {
	cd $LINUXDROID_PKG_SRCDIR
	$CC $CFLAGS fortune.c -o $LINUXDROID_PREFIX/bin/fortune
	mkdir -p $LINUXDROID_PREFIX/share/man/man6
	cp debian/fortune.6 $LINUXDROID_PREFIX/share/man/man6/

	local TARFILE=$LINUXDROID_PKG_CACHEDIR/f.tar.gz
	linuxdroid_download \
		http://http.debian.net/debian/pool/main/f/fortune-mod/fortune-mod_1.99.1.orig.tar.gz \
		$TARFILE \
		fc51aee1f73c936c885f4e0f8b6b48f4f68103e3896eaddc6a45d2b71e14eace

	cd $LINUXDROID_PKG_TMPDIR
	mkdir datfiles
	cd datfiles

	tar xf $TARFILE
	cd fortune-mod-1.99.1/datfiles

	rm -Rf html off Makefile
	mkdir -p $LINUXDROID_PREFIX/share/games/fortunes
	cp * $LINUXDROID_PREFIX/share/games/fortunes
}
