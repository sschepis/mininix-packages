LINUXDROID_PKG_HOMEPAGE=https://tasktools.org/projects/timewarrior.html
LINUXDROID_PKG_DESCRIPTION="Command-line time tracker"
LINUXDROID_PKG_VERSION=1.1.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=1f7d9a62e55fc5a3126433654ccb1fd7d2d135f06f05697f871897c9db77ccc9
LINUXDROID_PKG_SRCURL=https://taskwarrior.org/download/timew-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-glob"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

