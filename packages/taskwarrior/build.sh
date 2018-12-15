MININIX_PKG_HOMEPAGE=https://taskwarrior.org
MININIX_PKG_DESCRIPTION="Utility for managing your TODO list"
MININIX_PKG_VERSION=2.5.1
MININIX_PKG_REVISION=5
MININIX_PKG_SRCURL=https://taskwarrior.org/download/task-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=d87bcee58106eb8a79b850e9abc153d98b79e00d50eade0d63917154984f2a15
MININIX_PKG_DEPENDS="libgnutls, libuuid, libandroid-glob"
MININIX_PKG_KEEP_SHARE_DOC=yes

mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

