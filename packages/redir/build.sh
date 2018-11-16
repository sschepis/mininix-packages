LINUXDROID_PKG_HOMEPAGE=https://github.com/troglobit/redir
LINUXDROID_PKG_DESCRIPTION="TCP port redirector for UNIX"
LINUXDROID_PKG_VERSION=3.2
LINUXDROID_PKG_SHA256=e3c61bc4a51cf9228f916aeee3cb510bdff29ec2cdc2a1c8ae43d597bec89baa
LINUXDROID_PKG_SRCURL=https://github.com/troglobit/redir/releases/download/v$LINUXDROID_PKG_VERSION/redir-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC="yes"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -llog"
}
