MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/gnuit/
MININIX_PKG_DESCRIPTION="gnuit - GNU Interactive Tools"
MININIX_PKG_VERSION=4.9.5
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnuit/gnuit-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=6b6e96db13bafa5ad35c735b2277699d4244088c709a3e134fb1a3e8c8a8557c
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-transition"
MININIX_PKG_DEPENDS="ncurses"
mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-support"
}
mininix_step_post_massage() {
	cd $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/share/gnuit
	ln -s gnuitrc.xterm-color gnuitrc.xterm-256color
	ln -s gnuitrc.screen gnuitrc.screen-color
	ln -s gnuitrc.screen gnuitrc.screen-256color
}
