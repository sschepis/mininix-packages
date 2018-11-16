LINUXDROID_PKG_HOMEPAGE=https://github.com/karlstav/cava
LINUXDROID_PKG_DESCRIPTION="Console-based Audio Visualizer. Works with MPD and Pulseaudio"
LINUXDROID_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
LINUXDROID_PKG_VERSION=0.6.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=98b880e7e704ed457863f379f31b488e06076bb34a5de02825096969b916a78d
LINUXDROID_PKG_SRCURL=https://github.com/karlstav/cava/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="ncurses,fftw,libpulseaudio"
LINUXDROID_PKG_BUILD_DEPENDS="libtool"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	./autogen.sh
}
