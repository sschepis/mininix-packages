MININIX_PKG_HOMEPAGE=http://www.harding.motd.ca/autossh/
MININIX_PKG_DESCRIPTION="Automatically restart SSH sessions and tunnels"
MININIX_PKG_VERSION=1.4f
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=f47fe281a840e00a141204ad9cc54a9ebfb5af8235a45a3f25b14184934f05af
MININIX_PKG_SRCURL=https://fossies.org/linux/privat/autossh-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_PKG_DEPENDS="openssh | dropbear"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MININIX_PREFIX/share/man ac_cv_path_ssh=$MININIX_PREFIX/bin/ssh"

mininix_step_pre_configure () {
	# For syslog logging:
	LDFLAGS+=" -llog"
}
