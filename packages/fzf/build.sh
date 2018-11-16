LINUXDROID_PKG_HOMEPAGE=https://github.com/junegunn/fzf
LINUXDROID_PKG_DESCRIPTION="Command-line fuzzy finder"
LINUXDROID_PKG_VERSION=0.17.5
LINUXDROID_PKG_SHA256=de3b39758e01b19bbc04ee0d5107e14052d3a32ce8f40d4a63d0ed311394f7ee
LINUXDROID_PKG_SRCURL=https://github.com/junegunn/fzf/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC="yes"
# Depend on findutils as fzf uses the -fstype option, which busybox
# find does not support, when invoking find:
LINUXDROID_PKG_DEPENDS="bash, findutils"

linuxdroid_step_make() {
	:
}

linuxdroid_step_make_install () {
	linuxdroid_setup_golang
	export CGO_CFLAGS="-I$LINUXDROID_PREFIX/include"
	export CGO_LDFLAGS="-L$LINUXDROID_PREFIX/lib"

	# See the fzf Makefile:
	local _BINARY="target/fzf-${GOOS}_"
	if [ $LINUXDROID_ARCH = "arm" ]; then
		_BINARY+="arm7"
	elif [ $LINUXDROID_ARCH = "i686" ]; then
		_BINARY+="386"
	elif [ $LINUXDROID_ARCH = "x86_64" ]; then
		_BINARY+="amd64"
	elif [ $LINUXDROID_ARCH = "aarch64" ]; then
		_BINARY+="arm8"
	else
		linuxdroid_error_exit "Unsupported arch: $LINUXDROID_ARCH"
	fi

	LDFLAGS="-pie" make $_BINARY
	cp $_BINARY $LINUXDROID_PREFIX/bin/fzf

	# Install fzf-tmux, a bash script for launching fzf in a tmux pane:
	cp $LINUXDROID_PKG_SRCDIR/bin/fzf-tmux $LINUXDROID_PREFIX/bin

	# Install the fzf.1 man page:
	mkdir -p $LINUXDROID_PREFIX/share/man/man1/
	cp $LINUXDROID_PKG_SRCDIR/man/man1/fzf.1 $LINUXDROID_PREFIX/share/man/man1/

	# Install the vim plugin:
	mkdir -p $LINUXDROID_PREFIX/share/vim/vim81/plugin
	cp $LINUXDROID_PKG_SRCDIR/plugin/fzf.vim $LINUXDROID_PREFIX/share/vim/vim81/plugin/fzf.vim

	# Install bash completion script:
	mkdir -p $LINUXDROID_PREFIX/share/bash-completion/completions/
	cp $LINUXDROID_PKG_SRCDIR/shell/completion.bash $LINUXDROID_PREFIX/share/bash-completion/completions/fzf

	# Install the rest of the shell scripts:
	mkdir -p "$LINUXDROID_PREFIX/share/fzf"
	cp $LINUXDROID_PKG_SRCDIR/shell/* "$LINUXDROID_PREFIX/share/fzf"

	# Install the nvim plugin:
	mkdir -p $LINUXDROID_PREFIX/share/nvim/runtime/plugin
	cp $LINUXDROID_PKG_SRCDIR/plugin/fzf.vim $LINUXDROID_PREFIX/share/nvim/runtime/plugin/
}

linuxdroid_step_post_massage () {
	# Remove so that the vim build doesn't add it to vim-runtime:
	rm $LINUXDROID_PREFIX/share/vim/vim81/plugin/fzf.vim
}
