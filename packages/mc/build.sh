MININIX_PKG_HOMEPAGE=https://www.midnight-commander.org/
MININIX_PKG_DESCRIPTION="Midnight Commander - a powerful file manager"
MININIX_PKG_VERSION=4.8.21
MININIX_PKG_SHA256=8f37e546ac7c31c9c203a03b1c1d6cb2d2f623a300b86badfd367e5559fe148c
MININIX_PKG_SRCURL=http://ftp.midnight-commander.org/mc-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="libandroid-support, ncurses, glib"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_UNZIP=$MININIX_PREFIX/bin/unzip
ac_cv_path_ZIP=$MININIX_PREFIX/bin/zip
ac_cv_path_PERL=$MININIX_PREFIX/bin/perl
ac_cv_path_PYTHON=$MININIX_PREFIX/bin/python
ac_cv_path_RUBY=$MININIX_PREFIX/bin/ruby
--with-ncurses-includes=$MININIX_PREFIX/include
--with-ncurses-libs=$MININIX_PREFIX/lib
--with-screen=ncurses
"

mininix_step_pre_configure() {
	if [ "$MININIX_DEBUG" == "true" ]; then
		# Debug build fails with:
		# /home/builder/.mininix-build/mc/src/src/filemanager/file.c:2019:37: error: 'umask' called with invalid mode
		# src_mode = umask (-1);
		#                     ^
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}
