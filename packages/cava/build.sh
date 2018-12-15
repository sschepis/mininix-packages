MININIX_PKG_HOMEPAGE=https://github.com/karlstav/cava
MININIX_PKG_DESCRIPTION="Console-based Audio Visualizer. Works with MPD and Pulseaudio"
MININIX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MININIX_PKG_VERSION=0.6.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=98b880e7e704ed457863f379f31b488e06076bb34a5de02825096969b916a78d
MININIX_PKG_SRCURL=https://github.com/karlstav/cava/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="ncurses,fftw,libpulseaudio"
MININIX_PKG_BUILD_DEPENDS="libtool"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	./autogen.sh
}
