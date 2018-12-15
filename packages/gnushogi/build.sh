MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/gnushogi/
MININIX_PKG_DESCRIPTION="Program that plays the game of Shogi, also known as Japanese Chess"
MININIX_PKG_VERSION=1.4.2
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnushogi/gnushogi-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=1ecc48a866303c63652552b325d685e7ef5e9893244080291a61d96505d52b29
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_curses_clrtoeol=yes --with-curses"
MININIX_PKG_RM_AFTER_INSTALL="info/gnushogi.info"
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_HOSTBUILD=yes

mininix_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

mininix_step_post_configure () {
	cp $MININIX_PKG_HOSTBUILD_DIR/gnushogi/pat2inc $MININIX_PKG_BUILDDIR/gnushogi/pat2inc
	# Update timestamps so that the binaries does not get rebuilt:
	touch -d "next hour" $MININIX_PKG_BUILDDIR/gnushogi/pat2inc
}
