MININIX_PKG_HOMEPAGE=http://www.eblong.com/zarf/glulx/
MININIX_PKG_DESCRIPTION="Interpreter for the Glulx portable VM for interactive fiction (IF) games"
MININIX_PKG_VERSION=0.5.4
MININIX_PKG_SRCURL=http://www.eblong.com/zarf/glulx/glulxe-051.tar.gz
MININIX_PKG_SHA256=33c563bdbd0fdbae625e1a2441e9a6f40f1491f1cdc2a197bbd6cf2c32c3830d
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_PKG_DEPENDS="ncurses"

mininix_step_configure () {
	mininix_download http://eblong.com/zarf/glk/glktermw-104.tar.gz \
		$MININIX_PKG_CACHEDIR/glktermw-104.tar.gz \
		5968630b45e2fd53de48424559e3579db0537c460f4dc2631f258e1c116eb4ea
	tar xf $MININIX_PKG_CACHEDIR/glktermw-104.tar.gz
}

mininix_step_make () {
	cd $MININIX_PKG_SRCDIR/glkterm
	patch -p1 < $MININIX_PKG_BUILDER_DIR/glkterm.patch.special
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" PREFIX=$MININIX_PREFIX make -j 1

	cd ..
	make
	cp glulxe $MININIX_PREFIX/bin
}

mininix_step_make_install () {
	echo "Do nothing..."
}
