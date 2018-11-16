LINUXDROID_PKG_HOMEPAGE=https://github.com/nowsecure/fsmon
LINUXDROID_PKG_DESCRIPTION="Filesystem monitor with fanotify and inotify backends"
LINUXDROID_PKG_VERSION=1.5
LINUXDROID_PKG_SRCURL=https://github.com/nowsecure/fsmon/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=37ea1c83297976f5c7058637a328150dea57743d5eb55ebfc3a8075d262d67c2
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make() {
	make FANOTIFY_CFLAGS="-DHAVE_FANOTIFY=1 -DHAVE_SYS_FANOTIFY=0"
}
