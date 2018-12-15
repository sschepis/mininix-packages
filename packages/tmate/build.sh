MININIX_PKG_HOMEPAGE=https://tmate.io
MININIX_PKG_DESCRIPTION="Terminal multiplexer with instant terminal sharing"
MININIX_PKG_VERSION=2.2.1
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://github.com/tmate-io/tmate/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=d9c2ac59f42e65aac5f500f0548ea8056fd79c9c5285e5af324d833e2a84c305
MININIX_PKG_DEPENDS="libandroid-support, libevent, libmsgpack, libssh, libutil, ncurses"

mininix_step_pre_configure () {
	CFLAGS+=" -DIOV_MAX=1024"

	./autogen.sh
}
