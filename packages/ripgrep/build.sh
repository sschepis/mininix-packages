MININIX_PKG_HOMEPAGE=https://github.com/BurntSushi/ripgrep
MININIX_PKG_DESCRIPTION="Search tool like grep and The Silver Searcher"
MININIX_PKG_VERSION=0.10.0
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=a2a6eb7d33d75e64613c158e1ae450899b437e37f1bfbd54f713b011cd8cc31e
MININIX_PKG_SRCURL=https://github.com/BurntSushi/ripgrep/archive/$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_make_install() {
	# Install man page:
	mkdir -p $MININIX_PREFIX/share/man/man1/
	cp `find . -name rg.1` $MININIX_PREFIX/share/man/man1/

	# Install bash completion script:
	mkdir -p $MININIX_PREFIX/share/bash-completion/completions/
	cp `find . -name rg.bash` $MININIX_PREFIX/share/bash-completion/completions/rg

	# Install fish completion script:
	mkdir -p $MININIX_PREFIX/share/fish/completions/
	cp `find . -name rg.fish` $MININIX_PREFIX/share/fish/completions/

	# Install zsh completion script:
	mkdir -p $MININIX_PREFIX/share/zsh/site-functions/
	cp complete/_rg $MININIX_PREFIX/share/zsh/site-functions/
}
