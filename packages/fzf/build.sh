MININIX_PKG_HOMEPAGE=https://github.com/junegunn/fzf
MININIX_PKG_DESCRIPTION="Command-line fuzzy finder"
MININIX_PKG_VERSION=0.17.5
MININIX_PKG_SHA256=de3b39758e01b19bbc04ee0d5107e14052d3a32ce8f40d4a63d0ed311394f7ee
MININIX_PKG_SRCURL=https://github.com/junegunn/fzf/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC="yes"
# Depend on findutils as fzf uses the -fstype option, which busybox
# find does not support, when invoking find:
MININIX_PKG_DEPENDS="bash, findutils"

mininix_step_make() {
	:
}

mininix_step_make_install () {
	mininix_setup_golang
	export CGO_CFLAGS="-I$MININIX_PREFIX/include"
	export CGO_LDFLAGS="-L$MININIX_PREFIX/lib"

	# See the fzf Makefile:
	local _BINARY="target/fzf-${GOOS}_"
	if [ $MININIX_ARCH = "arm" ]; then
		_BINARY+="arm7"
	elif [ $MININIX_ARCH = "i686" ]; then
		_BINARY+="386"
	elif [ $MININIX_ARCH = "x86_64" ]; then
		_BINARY+="amd64"
	elif [ $MININIX_ARCH = "aarch64" ]; then
		_BINARY+="arm8"
	else
		mininix_error_exit "Unsupported arch: $MININIX_ARCH"
	fi

	LDFLAGS="-pie" make $_BINARY
	cp $_BINARY $MININIX_PREFIX/bin/fzf

	# Install fzf-tmux, a bash script for launching fzf in a tmux pane:
	cp $MININIX_PKG_SRCDIR/bin/fzf-tmux $MININIX_PREFIX/bin

	# Install the fzf.1 man page:
	mkdir -p $MININIX_PREFIX/share/man/man1/
	cp $MININIX_PKG_SRCDIR/man/man1/fzf.1 $MININIX_PREFIX/share/man/man1/

	# Install the vim plugin:
	mkdir -p $MININIX_PREFIX/share/vim/vim81/plugin
	cp $MININIX_PKG_SRCDIR/plugin/fzf.vim $MININIX_PREFIX/share/vim/vim81/plugin/fzf.vim

	# Install bash completion script:
	mkdir -p $MININIX_PREFIX/share/bash-completion/completions/
	cp $MININIX_PKG_SRCDIR/shell/completion.bash $MININIX_PREFIX/share/bash-completion/completions/fzf

	# Install the rest of the shell scripts:
	mkdir -p "$MININIX_PREFIX/share/fzf"
	cp $MININIX_PKG_SRCDIR/shell/* "$MININIX_PREFIX/share/fzf"

	# Install the nvim plugin:
	mkdir -p $MININIX_PREFIX/share/nvim/runtime/plugin
	cp $MININIX_PKG_SRCDIR/plugin/fzf.vim $MININIX_PREFIX/share/nvim/runtime/plugin/
}

mininix_step_post_massage () {
	# Remove so that the vim build doesn't add it to vim-runtime:
	rm $MININIX_PREFIX/share/vim/vim81/plugin/fzf.vim
}
