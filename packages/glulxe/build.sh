LINUXDROID_PKG_HOMEPAGE=http://www.eblong.com/zarf/glulx/
LINUXDROID_PKG_DESCRIPTION="Interpreter for the Glulx portable VM for interactive fiction (IF) games"
LINUXDROID_PKG_VERSION=0.5.4
LINUXDROID_PKG_SRCURL=http://www.eblong.com/zarf/glulx/glulxe-051.tar.gz
LINUXDROID_PKG_SHA256=33c563bdbd0fdbae625e1a2441e9a6f40f1491f1cdc2a197bbd6cf2c32c3830d
LINUXDROID_PKG_BUILD_IN_SRC="yes"
LINUXDROID_PKG_DEPENDS="ncurses"

linuxdroid_step_configure () {
	linuxdroid_download http://eblong.com/zarf/glk/glktermw-104.tar.gz \
		$LINUXDROID_PKG_CACHEDIR/glktermw-104.tar.gz \
		5968630b45e2fd53de48424559e3579db0537c460f4dc2631f258e1c116eb4ea
	tar xf $LINUXDROID_PKG_CACHEDIR/glktermw-104.tar.gz
}

linuxdroid_step_make () {
	cd $LINUXDROID_PKG_SRCDIR/glkterm
	patch -p1 < $LINUXDROID_PKG_BUILDER_DIR/glkterm.patch.special
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" PREFIX=$LINUXDROID_PREFIX make -j 1

	cd ..
	make
	cp glulxe $LINUXDROID_PREFIX/bin
}

linuxdroid_step_make_install () {
	echo "Do nothing..."
}
