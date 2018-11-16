LINUXDROID_PKG_HOMEPAGE=https://tmate.io
LINUXDROID_PKG_DESCRIPTION="Terminal multiplexer with instant terminal sharing"
LINUXDROID_PKG_VERSION=2.2.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://github.com/tmate-io/tmate/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=d9c2ac59f42e65aac5f500f0548ea8056fd79c9c5285e5af324d833e2a84c305
LINUXDROID_PKG_DEPENDS="libandroid-support, libevent, libmsgpack, libssh, libutil, ncurses"

linuxdroid_step_pre_configure () {
	CFLAGS+=" -DIOV_MAX=1024"

	./autogen.sh
}
