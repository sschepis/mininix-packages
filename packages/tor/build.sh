LINUXDROID_PKG_HOMEPAGE=https://www.torproject.org
LINUXDROID_PKG_DESCRIPTION="The Onion Router anonymizing overlay network"
LINUXDROID_PKG_DEPENDS="libevent, openssl, liblzma"
LINUXDROID_PKG_VERSION=0.3.4.9
LINUXDROID_PKG_SHA256=1a171081f02b9a6ff9e28c0898defb7670e5bbb3bdbcaddfcf4e4304aedd164a
LINUXDROID_PKG_SRCURL=https://www.torproject.org/dist/tor-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-zstd --disable-unittests"
LINUXDROID_PKG_CONFFILES="etc/tor/torrc"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"

linuxdroid_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog"
}

linuxdroid_step_post_make_install () {
	# use default config
	mv "$LINUXDROID_PREFIX/etc/tor/torrc.sample" "$LINUXDROID_PREFIX/etc/tor/torrc"
}
