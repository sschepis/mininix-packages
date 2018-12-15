MININIX_PKG_HOMEPAGE=https://www.torproject.org
MININIX_PKG_DESCRIPTION="The Onion Router anonymizing overlay network"
MININIX_PKG_DEPENDS="libevent, openssl, liblzma"
MININIX_PKG_VERSION=0.3.4.9
MININIX_PKG_SHA256=1a171081f02b9a6ff9e28c0898defb7670e5bbb3bdbcaddfcf4e4304aedd164a
MININIX_PKG_SRCURL=https://www.torproject.org/dist/tor-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-zstd --disable-unittests"
MININIX_PKG_CONFFILES="etc/tor/torrc"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"

mininix_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog"
}

mininix_step_post_make_install () {
	# use default config
	mv "$MININIX_PREFIX/etc/tor/torrc.sample" "$MININIX_PREFIX/etc/tor/torrc"
}
