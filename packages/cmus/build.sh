LINUXDROID_PKG_HOMEPAGE=https://cmus.github.io/
LINUXDROID_PKG_DESCRIPTION="Small, fast and powerful console music player"
LINUXDROID_PKG_VERSION=2.7.1
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_SHA256=8179a7a843d257ddb585f4c65599844bc0e516fe85e97f6f87a7ceade4eb5165
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses, libflac, libmad, libvorbis, opusfile, libcue, libpulseaudio"
LINUXDROID_PKG_SRCURL=https://github.com/cmus/cmus/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	LD=$CC
	export CONFIG_OSS=n
}

linuxdroid_step_configure () {
	./configure prefix=$LINUXDROID_PREFIX
}
