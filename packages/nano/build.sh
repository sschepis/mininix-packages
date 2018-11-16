LINUXDROID_PKG_HOMEPAGE=https://www.nano-editor.org/
LINUXDROID_PKG_DESCRIPTION="Small, free and friendly text editor"
LINUXDROID_PKG_VERSION=3.2
LINUXDROID_PKG_SHA256=d12773af3589994b2e4982c5792b07c6240da5b86c5aef2103ab13b401fe6349
LINUXDROID_PKG_SRCURL=https://nano-editor.org/dist/latest/nano-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_DEPENDS="libandroid-support, libandroid-glob, ncurses"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_pwd_h=no
--disable-libmagic
--enable-utf8
--with-wordbounds
"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/rnano share/man/man1/rnano.1 share/nano/man-html"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	if [ "$LINUXDROID_DEBUG" == "true" ]; then
		# When doing debug build, -D_FORTIFY_SOURCE=2 gives this error:
		# /home/builder/.linuxdroid-build/_lib/16-aarch64-21-v3/bin/../sysroot/usr/include/bits/fortify/string.h:79:26: error: use of undeclared identifier '__USE_FORTIFY_LEVEL'
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}

linuxdroid_step_post_make_install () {
	# Configure nano to use syntax highlighting:
	NANORC=$LINUXDROID_PREFIX/etc/nanorc
	echo include \"$LINUXDROID_PREFIX/share/nano/\*nanorc\" > $NANORC
}
