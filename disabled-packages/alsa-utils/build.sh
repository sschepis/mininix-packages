MININIX_PKG_HOMEPAGE=http://www.alsa-project.org
MININIX_PKG_VERSION=1.1.3
MININIX_PKG_SRCURL=ftp://ftp.alsa-project.org/pub/utils/alsa-utils-$MININIX_PKG_VERSION.tar.bz2
MININIX_PKG_SHA256=127217a54eea0f9a49700a2f239a2d4f5384aa094d68df04a8eb80132eb6167c
MININIX_PKG_DEPENDS="alsa-lib, ncurses"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-udev-rules-dir=$MININIX_PREFIX/lib/udev/rules.d --with-asound-state-dir=$MININIX_PREFIX/var/lib/alsa --disable-bat --disable-rst2man"

mininix_step_pre_configure () {
    LDFLAGS+=" -llog"
}
