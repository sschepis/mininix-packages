LINUXDROID_PKG_HOMEPAGE=https://fishshell.com/
LINUXDROID_PKG_DESCRIPTION="Shell geared towards interactive use"
LINUXDROID_PKG_VERSION=2.7.1
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SHA256=e42bb19c7586356905a58578190be792df960fa81de35effb1ca5a5a981f0c5a
LINUXDROID_PKG_SRCURL=https://github.com/fish-shell/fish-shell/releases/download/$LINUXDROID_PKG_VERSION/fish-${LINUXDROID_PKG_VERSION}.tar.gz
# fish calls 'tput' from ncurses-utils, at least when cancelling (Ctrl+C) a command line.
# man is needed since fish calls apropos during command completion.
LINUXDROID_PKG_DEPENDS="ncurses, libandroid-support, ncurses-utils, man, bc, pcre2"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__proc_self_stat=yes
--without-included-pcre2
"

linuxdroid_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
}

linuxdroid_step_post_make_install () {
	cat >> $LINUXDROID_PREFIX/etc/fish/config.fish <<HERE

function __fish_command_not_found_handler --on-event fish_command_not_found
	$LINUXDROID_PREFIX/libexec/linuxdroid/command-not-found \$argv[1]
end
HERE
}
