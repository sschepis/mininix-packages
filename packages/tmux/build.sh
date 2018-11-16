LINUXDROID_PKG_HOMEPAGE=https://tmux.github.io/
LINUXDROID_PKG_DESCRIPTION="Terminal multiplexer"
# Link against libandroid-support for wcwidth(), see https://github.com/linuxdroid/linuxdroid-packages/issues/224
LINUXDROID_PKG_DEPENDS="ncurses, libevent, libutil, libandroid-support, libandroid-glob"
LINUXDROID_PKG_VERSION=2.8
LINUXDROID_PKG_SHA256=7f6bf335634fafecff878d78de389562ea7f73a7367f268b66d37ea13617a2ba
LINUXDROID_PKG_SRCURL=https://github.com/tmux/tmux/releases/download/${LINUXDROID_PKG_VERSION}/tmux-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

linuxdroid_step_post_make_install () {
	cp $LINUXDROID_PKG_BUILDER_DIR/tmux.conf $LINUXDROID_PREFIX/etc/tmux.conf
}
