LINUXDROID_PKG_HOMEPAGE=http://www.bzip.org/
LINUXDROID_PKG_DESCRIPTION="BZ2 format compression library"
LINUXDROID_PKG_VERSION=1.0.6
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=4bbea71ae30a0e5a8ddcee8da750bc978a479ba11e04498d082fa65c2f8c1ad5
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/bzip2-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_EXTRA_MAKE_ARGS="PREFIX=$LINUXDROID_PREFIX"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure () {
	# bzip2 does not use configure. But place man pages at correct path:
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" $LINUXDROID_PKG_SRCDIR/Makefile
}

linuxdroid_step_make () {
	# bzip2 uses a separate makefile for the shared library
	make -f Makefile-libbz2_so
}

linuxdroid_step_make_install () {
	# The shared library makefile contains no install makefile, so issue a normal install to get scripts
	make $LINUXDROID_PKG_EXTRA_MAKE_ARGS install

	# Clean out statically linked binaries and libs and replace them with shared ones:
	rm -Rf $LINUXDROID_PREFIX/lib/libbz2*
	rm -Rf $LINUXDROID_PREFIX/bin/{bzcat,bunzip2}
	cp bzip2-shared $LINUXDROID_PREFIX/bin/bzip2
	cp libbz2.so.${LINUXDROID_PKG_VERSION} $LINUXDROID_PREFIX/lib
	(cd $LINUXDROID_PREFIX/lib && ln -s libbz2.so.${LINUXDROID_PKG_VERSION} libbz2.so.1.0)
	(cd $LINUXDROID_PREFIX/lib && ln -s libbz2.so.${LINUXDROID_PKG_VERSION} libbz2.so)
	(cd $LINUXDROID_PREFIX/bin && ln -s bzip2 bzcat)
	(cd $LINUXDROID_PREFIX/bin && ln -s bzip2 bunzip2)
	# bzgrep should be enough so remove bz{e,f}grep
	rm $LINUXDROID_PREFIX/bin/bz{e,f}grep $LINUXDROID_PREFIX/share/man/man1/bz{e,f}grep.1
}
