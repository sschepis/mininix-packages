MININIX_PKG_HOMEPAGE=https://taskwarrior.org
MININIX_PKG_DESCRIPTION="Shell command wrapping Taskwarrior commands"
MININIX_PKG_VERSION=1.2.0
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://taskwarrior.org/download/tasksh-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=6e42f949bfd7fbdde4870af0e7b923114cc96c4344f82d9d924e984629e21ffd
MININIX_PKG_DEPENDS="readline, taskwarrior, libandroid-glob"

mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

