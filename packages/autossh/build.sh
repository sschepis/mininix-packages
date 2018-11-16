LINUXDROID_PKG_HOMEPAGE=http://www.harding.motd.ca/autossh/
LINUXDROID_PKG_DESCRIPTION="Automatically restart SSH sessions and tunnels"
LINUXDROID_PKG_VERSION=1.4f
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=f47fe281a840e00a141204ad9cc54a9ebfb5af8235a45a3f25b14184934f05af
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/privat/autossh-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC="yes"
LINUXDROID_PKG_DEPENDS="openssh | dropbear"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$LINUXDROID_PREFIX/share/man ac_cv_path_ssh=$LINUXDROID_PREFIX/bin/ssh"

linuxdroid_step_pre_configure () {
	# For syslog logging:
	LDFLAGS+=" -llog"
}
