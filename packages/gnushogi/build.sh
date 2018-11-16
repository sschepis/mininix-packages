LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gnushogi/
LINUXDROID_PKG_DESCRIPTION="Program that plays the game of Shogi, also known as Japanese Chess"
LINUXDROID_PKG_VERSION=1.4.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnushogi/gnushogi-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=1ecc48a866303c63652552b325d685e7ef5e9893244080291a61d96505d52b29
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_curses_clrtoeol=yes --with-curses"
LINUXDROID_PKG_RM_AFTER_INSTALL="info/gnushogi.info"
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_HOSTBUILD=yes

linuxdroid_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

linuxdroid_step_post_configure () {
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/gnushogi/pat2inc $LINUXDROID_PKG_BUILDDIR/gnushogi/pat2inc
	# Update timestamps so that the binaries does not get rebuilt:
	touch -d "next hour" $LINUXDROID_PKG_BUILDDIR/gnushogi/pat2inc
}
