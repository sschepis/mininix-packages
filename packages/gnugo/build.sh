MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/gnugo/
MININIX_PKG_DESCRIPTION="Program that plays the game of Go"
MININIX_PKG_VERSION=3.8
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnugo/gnugo-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72
MININIX_PKG_DEPENDS="ncurses, readline"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-readline"
MININIX_PKG_HOSTBUILD=yes

mininix_step_pre_configure() {
	CFLAGS+=" -Wno-overflow"
}

mininix_step_post_configure () {
	cp $MININIX_PKG_HOSTBUILD_DIR/patterns/mkeyes $MININIX_PKG_BUILDDIR/patterns/mkeyes
	cp $MININIX_PKG_HOSTBUILD_DIR/patterns/uncompress_fuseki $MININIX_PKG_BUILDDIR/patterns/uncompress_fuseki
	cp $MININIX_PKG_HOSTBUILD_DIR/patterns/joseki $MININIX_PKG_BUILDDIR/patterns/joseki
	cp $MININIX_PKG_HOSTBUILD_DIR/patterns/mkmcpat $MININIX_PKG_BUILDDIR/patterns/mkmcpat
	cp $MININIX_PKG_HOSTBUILD_DIR/patterns/mkpat $MININIX_PKG_BUILDDIR/patterns/mkpat
	touch -d "next hour" $MININIX_PKG_BUILDDIR/patterns/*
}
