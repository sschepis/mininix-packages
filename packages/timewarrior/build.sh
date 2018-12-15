MININIX_PKG_HOMEPAGE=https://tasktools.org/projects/timewarrior.html
MININIX_PKG_DESCRIPTION="Command-line time tracker"
MININIX_PKG_VERSION=1.1.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=1f7d9a62e55fc5a3126433654ccb1fd7d2d135f06f05697f871897c9db77ccc9
MININIX_PKG_SRCURL=https://taskwarrior.org/download/timew-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libandroid-glob"

mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

