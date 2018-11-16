LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gnugo/
LINUXDROID_PKG_DESCRIPTION="Program that plays the game of Go"
LINUXDROID_PKG_VERSION=3.8
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnugo/gnugo-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72
LINUXDROID_PKG_DEPENDS="ncurses, readline"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-readline"
LINUXDROID_PKG_HOSTBUILD=yes

linuxdroid_step_pre_configure() {
	CFLAGS+=" -Wno-overflow"
}

linuxdroid_step_post_configure () {
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/patterns/mkeyes $LINUXDROID_PKG_BUILDDIR/patterns/mkeyes
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/patterns/uncompress_fuseki $LINUXDROID_PKG_BUILDDIR/patterns/uncompress_fuseki
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/patterns/joseki $LINUXDROID_PKG_BUILDDIR/patterns/joseki
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/patterns/mkmcpat $LINUXDROID_PKG_BUILDDIR/patterns/mkmcpat
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/patterns/mkpat $LINUXDROID_PKG_BUILDDIR/patterns/mkpat
	touch -d "next hour" $LINUXDROID_PKG_BUILDDIR/patterns/*
}
