MININIX_PKG_HOMEPAGE=http://www.bzip.org/
MININIX_PKG_DESCRIPTION="BZ2 format compression library"
MININIX_PKG_VERSION=1.0.6
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=4bbea71ae30a0e5a8ddcee8da750bc978a479ba11e04498d082fa65c2f8c1ad5
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/bzip2-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_EXTRA_MAKE_ARGS="PREFIX=$MININIX_PREFIX"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_configure () {
	# bzip2 does not use configure. But place man pages at correct path:
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" $MININIX_PKG_SRCDIR/Makefile
}

mininix_step_make () {
	# bzip2 uses a separate makefile for the shared library
	make -f Makefile-libbz2_so
}

mininix_step_make_install () {
	# The shared library makefile contains no install makefile, so issue a normal install to get scripts
	make $MININIX_PKG_EXTRA_MAKE_ARGS install

	# Clean out statically linked binaries and libs and replace them with shared ones:
	rm -Rf $MININIX_PREFIX/lib/libbz2*
	rm -Rf $MININIX_PREFIX/bin/{bzcat,bunzip2}
	cp bzip2-shared $MININIX_PREFIX/bin/bzip2
	cp libbz2.so.${MININIX_PKG_VERSION} $MININIX_PREFIX/lib
	(cd $MININIX_PREFIX/lib && ln -s libbz2.so.${MININIX_PKG_VERSION} libbz2.so.1.0)
	(cd $MININIX_PREFIX/lib && ln -s libbz2.so.${MININIX_PKG_VERSION} libbz2.so)
	(cd $MININIX_PREFIX/bin && ln -s bzip2 bzcat)
	(cd $MININIX_PREFIX/bin && ln -s bzip2 bunzip2)
	# bzgrep should be enough so remove bz{e,f}grep
	rm $MININIX_PREFIX/bin/bz{e,f}grep $MININIX_PREFIX/share/man/man1/bz{e,f}grep.1
}
