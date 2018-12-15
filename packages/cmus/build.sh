MININIX_PKG_HOMEPAGE=https://cmus.github.io/
MININIX_PKG_DESCRIPTION="Small, fast and powerful console music player"
MININIX_PKG_VERSION=2.7.1
MININIX_PKG_REVISION=3
MININIX_PKG_SHA256=8179a7a843d257ddb585f4c65599844bc0e516fe85e97f6f87a7ceade4eb5165
MININIX_PKG_DEPENDS="libandroid-support, ncurses, libflac, libmad, libvorbis, opusfile, libcue, libpulseaudio"
MININIX_PKG_SRCURL=https://github.com/cmus/cmus/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	LD=$CC
	export CONFIG_OSS=n
}

mininix_step_configure () {
	./configure prefix=$MININIX_PREFIX
}
