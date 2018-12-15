MININIX_PKG_HOMEPAGE=https://github.com/troglobit/redir
MININIX_PKG_DESCRIPTION="TCP port redirector for UNIX"
MININIX_PKG_VERSION=3.2
MININIX_PKG_SHA256=e3c61bc4a51cf9228f916aeee3cb510bdff29ec2cdc2a1c8ae43d597bec89baa
MININIX_PKG_SRCURL=https://github.com/troglobit/redir/releases/download/v$MININIX_PKG_VERSION/redir-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"

mininix_step_pre_configure() {
	LDFLAGS+=" -llog"
}
