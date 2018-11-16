LINUXDROID_PKG_HOMEPAGE=https://www.midnight-commander.org/
LINUXDROID_PKG_DESCRIPTION="Midnight Commander - a powerful file manager"
LINUXDROID_PKG_VERSION=4.8.21
LINUXDROID_PKG_SHA256=8f37e546ac7c31c9c203a03b1c1d6cb2d2f623a300b86badfd367e5559fe148c
LINUXDROID_PKG_SRCURL=http://ftp.midnight-commander.org/mc-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses, glib"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_UNZIP=$LINUXDROID_PREFIX/bin/unzip
ac_cv_path_ZIP=$LINUXDROID_PREFIX/bin/zip
ac_cv_path_PERL=$LINUXDROID_PREFIX/bin/perl
ac_cv_path_PYTHON=$LINUXDROID_PREFIX/bin/python
ac_cv_path_RUBY=$LINUXDROID_PREFIX/bin/ruby
--with-ncurses-includes=$LINUXDROID_PREFIX/include
--with-ncurses-libs=$LINUXDROID_PREFIX/lib
--with-screen=ncurses
"

linuxdroid_step_pre_configure() {
	if [ "$LINUXDROID_DEBUG" == "true" ]; then
		# Debug build fails with:
		# /home/builder/.linuxdroid-build/mc/src/src/filemanager/file.c:2019:37: error: 'umask' called with invalid mode
		# src_mode = umask (-1);
		#                     ^
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}
