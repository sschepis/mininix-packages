LINUXDROID_PKG_HOMEPAGE=https://tinyproxy.github.io/
LINUXDROID_PKG_DESCRIPTION="Light-weight HTTP proxy daemon for POSIX operating systems"
LINUXDROID_PKG_VERSION=1.10.0
LINUXDROID_PKG_SHA256=59be87689c415ba0d9c9bc6babbdd3df3b372d60b21e526b118d722dbc995682
LINUXDROID_PKG_SRCURL=https://github.com/tinyproxy/tinyproxy/releases/download/${LINUXDROID_PKG_VERSION}/tinyproxy-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-regexcheck"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -llog"
}

linuxdroid_step_post_massage() {
	mkdir -p $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/var/log/$LINUXDROID_PKG_NAME
	mkdir -p $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/var/run/$LINUXDROID_PKG_NAME
	find $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/var -exec chmod -f u+w,g-rwx,o-rwx \{\} \;
}
