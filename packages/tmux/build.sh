MININIX_PKG_HOMEPAGE=https://tmux.github.io/
MININIX_PKG_DESCRIPTION="Terminal multiplexer"
# Link against libandroid-support for wcwidth(), see https://github.com/mininix/mininix-packages/issues/224
MININIX_PKG_DEPENDS="ncurses, libevent, libutil, libandroid-support, libandroid-glob"
MININIX_PKG_VERSION=2.8
MININIX_PKG_SHA256=7f6bf335634fafecff878d78de389562ea7f73a7367f268b66d37ea13617a2ba
MININIX_PKG_SRCURL=https://github.com/tmux/tmux/releases/download/${MININIX_PKG_VERSION}/tmux-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

mininix_step_post_make_install () {
	cp $MININIX_PKG_BUILDER_DIR/tmux.conf $MININIX_PREFIX/etc/tmux.conf
}
