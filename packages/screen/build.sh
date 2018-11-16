LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/screen/
LINUXDROID_PKG_DESCRIPTION="Terminal multiplexer with VT100/ANSI terminal emulation"
LINUXDROID_PKG_VERSION=4.6.2
LINUXDROID_PKG_SHA256=1b6922520e6a0ce5e28768d620b0f640a6631397f95ccb043b70b91bb503fa3a
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/screen/screen-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="ncurses, libcrypt, libutil"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-socket-dir
--enable-colors256
--with-ssl=openssl
"

linuxdroid_step_pre_configure () {
	# Run autoreconf since we have patched configure.ac
	autoconf
	CFLAGS+=" -DGETUTENT"
	LDFLAGS+=" -llog -lcrypt"
}

linuxdroid_step_post_configure() {
	echo '#define HAVE_SVR4_PTYS 1' >> $LINUXDROID_PKG_BUILDDIR/config.h
	echo 'mousetrack on' > "$LINUXDROID_PREFIX/etc/screenrc"
}
