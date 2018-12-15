MININIX_PKG_HOMEPAGE=https://www.gnu.org.ua/software/direvent/
MININIX_PKG_DESCRIPTION="Monitor of events in file system directories"
MININIX_PKG_VERSION=5.1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/direvent/direvent-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=c461600d24183563a4ea47c2fd806037a43354ea68014646b424ac797a959bdb
MININIX_PKG_DEPENDS="libandroid-glob"

mininix_step_pre_configure() {
	LDFLAGS+=" -llog -landroid-glob"
}
