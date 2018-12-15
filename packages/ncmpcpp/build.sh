MININIX_PKG_HOMEPAGE=https://rybczak.net/ncmpcpp/
MININIX_PKG_DESCRIPTION="NCurses Music Player Client (Plus Plus)"
MININIX_PKG_VERSION=0.8.2
MININIX_PKG_REVISION=4
MININIX_PKG_SHA256=650ba3e8089624b7ad9e4cc19bc1ac6028edb7523cc111fa1686ea44c0921554
MININIX_PKG_SRCURL=https://rybczak.net/ncmpcpp/stable/ncmpcpp-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="fftw, boost, readline, libcurl, libmpdclient, ncurses"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_KEEP_SHARE_DOC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--enable-visualizer --enable-outputs --enable-clock"

mininix_step_pre_configure() {
	./autogen.sh
	CXXFLAGS+=" -DNCURSES_WIDECHAR -U_XOPEN_SOURCE"
}
