MININIX_PKG_HOMEPAGE=https://www.vim.org
MININIX_PKG_DESCRIPTION="Vi IMproved - enhanced vi editor"
MININIX_PKG_DEPENDS="ncurses, vim-runtime"
# vim should only be updated every 50 releases on multiples of 50.
# Update both vim and vim-python to the same version in one PR.
MININIX_PKG_VERSION=8.1.0550
MININIX_PKG_SHA256=f3e54f9f6fdce93562c360a23166df2f455a257289fc31572f331948fd432ec4
MININIX_PKG_SRCURL="https://github.com/vim/vim/archive/v${MININIX_PKG_VERSION}.tar.gz"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_tgetent=zero
vim_cv_toupper_broken=no
vim_cv_tty_group=world
--enable-gui=no
--enable-multibyte
--with-features=huge
--without-x
--with-tlib=ncursesw
"
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_PKG_RM_AFTER_INSTALL="
bin/rview
bin/rvim
bin/ex
share/man/man1/evim.1
share/icons
share/vim/vim81/spell/en.ascii*
share/vim/vim81/print
share/vim/vim81/tools
"
MININIX_PKG_CONFFILES="share/vim/vimrc"

MININIX_PKG_CONFLICTS="vim-python"

mininix_step_pre_configure () {
	make distclean

	# Remove eventually existing symlinks from previous builds so that they get re-created
	for b in rview rvim ex view vimdiff; do rm -f $MININIX_PREFIX/bin/$b; done
	rm -f $MININIX_PREFIX/share/man/man1/view.1
}

mininix_step_post_make_install () {
	cp $MININIX_PKG_BUILDER_DIR/vimrc $MININIX_PREFIX/share/vim/vimrc

	# Remove most tutor files:
	cp $MININIX_PREFIX/share/vim/vim81/tutor/{tutor,tutor.vim,tutor.utf-8} $MININIX_PKG_TMPDIR/
	rm -f $MININIX_PREFIX/share/vim/vim81/tutor/*
	cp $MININIX_PKG_TMPDIR/{tutor,tutor.vim,tutor.utf-8} $MININIX_PREFIX/share/vim/vim81/tutor/

	cd $MININIX_PREFIX/bin
	ln -f -s vim vi
}
