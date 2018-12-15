MININIX_PKG_HOMEPAGE=https://www.zsh.org
MININIX_PKG_DESCRIPTION="Shell with lots of features"
MININIX_PKG_VERSION=5.6.2
MININIX_PKG_SHA256=a50bd66c0557e8eca3b8fa24e85d0de533e775d7a22df042da90488623752e9e
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/zsh-${MININIX_PKG_VERSION}.tar.xz
# Remove hard link to bin/zsh as Android does not support hard links:
MININIX_PKG_RM_AFTER_INSTALL="bin/zsh-${MININIX_PKG_VERSION}"
MININIX_PKG_DEPENDS="libandroid-support, ncurses, mininix-tools, command-not-found, pcre"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_utmp_h=no
ac_cv_func_getpwuid=yes
--disable-gdbm
--enable-pcre
--enable-etcdir=$MININIX_PREFIX/etc
"
MININIX_PKG_CONFFILES="etc/zshrc"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_configure () {
	# INSTALL file: "For a non-dynamic zsh, the default is to compile the complete, compctl, zle,
	# computil, complist, sched, # parameter, zleparameter and rlimits modules into the shell,
	# and you will need to edit config.modules to make any other modules available."
	# Since we build zsh non-dynamically (since dynamic loading doesn't work on Android when enabled),
	# we need to explicitly enable the additional modules we want.
	# - The files module is needed by `compinstall` (https://github.com/mininix/mininix-packages/issues/61).
	# - The regex module seems to be used by several extensions.
	# - The curses, socket and zprof modules was desired by BrainDamage on IRC (#mininix).
	# - The deltochar and mathfunc modules is used by grml-zshrc (https://github.com/mininix/mininix-packages/issues/494).
	# - The system module is needed by zplug (https://github.com/mininix/mininix-packages/issues/659).
	# - The zpty module is needed by zsh-async (https://github.com/mininix/mininix-packages/issues/672).
	# - The stat module is needed by zui (https://github.com/mininix/mininix-packages/issues/2829).
	for module in files regex curses zprof socket system deltochar mathfunc zpty pcre stat; do
		perl -p -i -e "s|${module}.mdd link=no|${module}.mdd link=static|" $MININIX_PKG_BUILDDIR/config.modules
	done
}

mininix_step_post_make_install () {
	# /etc/zshrc - Run for interactive shells (http://zsh.sourceforge.net/Guide/zshguide02.html):
	sed "s|@MININIX_PREFIX@|$MININIX_PREFIX|" $MININIX_PKG_BUILDER_DIR/etc-zshrc > $MININIX_PREFIX/etc/zshrc

	# Remove zsh.new/zsh.old/zsh-$version if any exists:
	rm -f $MININIX_PREFIX/{zsh-*,zsh.*}
}
