MININIX_PKG_HOMEPAGE=https://tinyproxy.github.io/
MININIX_PKG_DESCRIPTION="Light-weight HTTP proxy daemon for POSIX operating systems"
MININIX_PKG_VERSION=1.10.0
MININIX_PKG_SHA256=59be87689c415ba0d9c9bc6babbdd3df3b372d60b21e526b118d722dbc995682
MININIX_PKG_SRCURL=https://github.com/tinyproxy/tinyproxy/releases/download/${MININIX_PKG_VERSION}/tinyproxy-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-regexcheck"

mininix_step_pre_configure() {
	LDFLAGS+=" -llog"
}

mininix_step_post_massage() {
	mkdir -p $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/var/log/$MININIX_PKG_NAME
	mkdir -p $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/var/run/$MININIX_PKG_NAME
	find $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/var -exec chmod -f u+w,g-rwx,o-rwx \{\} \;
}
