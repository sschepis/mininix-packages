LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org.ua/software/direvent/
LINUXDROID_PKG_DESCRIPTION="Monitor of events in file system directories"
LINUXDROID_PKG_VERSION=5.1
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/direvent/direvent-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=c461600d24183563a4ea47c2fd806037a43354ea68014646b424ac797a959bdb
LINUXDROID_PKG_DEPENDS="libandroid-glob"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -llog -landroid-glob"
}
