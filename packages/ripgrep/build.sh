LINUXDROID_PKG_HOMEPAGE=https://github.com/BurntSushi/ripgrep
LINUXDROID_PKG_DESCRIPTION="Search tool like grep and The Silver Searcher"
LINUXDROID_PKG_VERSION=0.10.0
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=a2a6eb7d33d75e64613c158e1ae450899b437e37f1bfbd54f713b011cd8cc31e
LINUXDROID_PKG_SRCURL=https://github.com/BurntSushi/ripgrep/archive/$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_make_install() {
	# Install man page:
	mkdir -p $LINUXDROID_PREFIX/share/man/man1/
	cp `find . -name rg.1` $LINUXDROID_PREFIX/share/man/man1/

	# Install bash completion script:
	mkdir -p $LINUXDROID_PREFIX/share/bash-completion/completions/
	cp `find . -name rg.bash` $LINUXDROID_PREFIX/share/bash-completion/completions/rg

	# Install fish completion script:
	mkdir -p $LINUXDROID_PREFIX/share/fish/completions/
	cp `find . -name rg.fish` $LINUXDROID_PREFIX/share/fish/completions/

	# Install zsh completion script:
	mkdir -p $LINUXDROID_PREFIX/share/zsh/site-functions/
	cp complete/_rg $LINUXDROID_PREFIX/share/zsh/site-functions/
}
