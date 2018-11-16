LINUXDROID_PKG_HOMEPAGE=https://rybczak.net/ncmpcpp/
LINUXDROID_PKG_DESCRIPTION="NCurses Music Player Client (Plus Plus)"
LINUXDROID_PKG_VERSION=0.8.2
LINUXDROID_PKG_REVISION=4
LINUXDROID_PKG_SHA256=650ba3e8089624b7ad9e4cc19bc1ac6028edb7523cc111fa1686ea44c0921554
LINUXDROID_PKG_SRCURL=https://rybczak.net/ncmpcpp/stable/ncmpcpp-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="fftw, boost, readline, libcurl, libmpdclient, ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_KEEP_SHARE_DOC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--enable-visualizer --enable-outputs --enable-clock"

linuxdroid_step_pre_configure() {
	./autogen.sh
	CXXFLAGS+=" -DNCURSES_WIDECHAR -U_XOPEN_SOURCE"
}
