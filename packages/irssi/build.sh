MININIX_PKG_HOMEPAGE=https://irssi.org/
MININIX_PKG_DESCRIPTION="Terminal based IRC client"
MININIX_PKG_DEPENDS="ncurses, openssl, glib, libandroid-glob"
MININIX_PKG_VERSION=1.1.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=784807e7a1ba25212347f03e4287cff9d0659f076edfb2c6b20928021d75a1bf
MININIX_PKG_SRCURL=https://github.com/irssi/irssi/releases/download/$MININIX_PKG_VERSION/irssi-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	LDFLAGS+=" -landroid-glob"
}
