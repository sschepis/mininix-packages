LINUXDROID_PKG_HOMEPAGE=https://taskwarrior.org
LINUXDROID_PKG_DESCRIPTION="Utility for managing your TODO list"
LINUXDROID_PKG_VERSION=2.5.1
LINUXDROID_PKG_REVISION=5
LINUXDROID_PKG_SRCURL=https://taskwarrior.org/download/task-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=d87bcee58106eb8a79b850e9abc153d98b79e00d50eade0d63917154984f2a15
LINUXDROID_PKG_DEPENDS="libgnutls, libuuid, libandroid-glob"
LINUXDROID_PKG_KEEP_SHARE_DOC=yes

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

