LINUXDROID_PKG_HOMEPAGE=https://irssi.org/
LINUXDROID_PKG_DESCRIPTION="Terminal based IRC client"
LINUXDROID_PKG_DEPENDS="ncurses, openssl, glib, libandroid-glob"
LINUXDROID_PKG_VERSION=1.1.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=784807e7a1ba25212347f03e4287cff9d0659f076edfb2c6b20928021d75a1bf
LINUXDROID_PKG_SRCURL=https://github.com/irssi/irssi/releases/download/$LINUXDROID_PKG_VERSION/irssi-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	LDFLAGS+=" -landroid-glob"
}
