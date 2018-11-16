LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gnuit/
LINUXDROID_PKG_DESCRIPTION="gnuit - GNU Interactive Tools"
LINUXDROID_PKG_VERSION=4.9.5
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnuit/gnuit-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=6b6e96db13bafa5ad35c735b2277699d4244088c709a3e134fb1a3e8c8a8557c
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-transition"
LINUXDROID_PKG_DEPENDS="ncurses"
linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-support"
}
linuxdroid_step_post_massage() {
	cd $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/share/gnuit
	ln -s gnuitrc.xterm-color gnuitrc.xterm-256color
	ln -s gnuitrc.screen gnuitrc.screen-color
	ln -s gnuitrc.screen gnuitrc.screen-256color
}
