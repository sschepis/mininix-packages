LINUXDROID_PKG_HOMEPAGE=https://taskwarrior.org
LINUXDROID_PKG_DESCRIPTION="Shell command wrapping Taskwarrior commands"
LINUXDROID_PKG_VERSION=1.2.0
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://taskwarrior.org/download/tasksh-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=6e42f949bfd7fbdde4870af0e7b923114cc96c4344f82d9d924e984629e21ffd
LINUXDROID_PKG_DEPENDS="readline, taskwarrior, libandroid-glob"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

