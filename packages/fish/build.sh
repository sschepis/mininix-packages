MININIX_PKG_HOMEPAGE=https://fishshell.com/
MININIX_PKG_DESCRIPTION="Shell geared towards interactive use"
MININIX_PKG_VERSION=2.7.1
MININIX_PKG_REVISION=2
MININIX_PKG_SHA256=e42bb19c7586356905a58578190be792df960fa81de35effb1ca5a5a981f0c5a
MININIX_PKG_SRCURL=https://github.com/fish-shell/fish-shell/releases/download/$MININIX_PKG_VERSION/fish-${MININIX_PKG_VERSION}.tar.gz
# fish calls 'tput' from ncurses-utils, at least when cancelling (Ctrl+C) a command line.
# man is needed since fish calls apropos during command completion.
MININIX_PKG_DEPENDS="ncurses, libandroid-support, ncurses-utils, man, bc, pcre2"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__proc_self_stat=yes
--without-included-pcre2
"

mininix_step_pre_configure() {
	CXXFLAGS+=" $CPPFLAGS"
}

mininix_step_post_make_install () {
	cat >> $MININIX_PREFIX/etc/fish/config.fish <<HERE

function __fish_command_not_found_handler --on-event fish_command_not_found
	$MININIX_PREFIX/libexec/mininix/command-not-found \$argv[1]
end
HERE
}
