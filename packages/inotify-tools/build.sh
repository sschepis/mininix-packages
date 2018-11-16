LINUXDROID_PKG_HOMEPAGE=https://github.com/rvoicilas/inotify-tools/wiki
LINUXDROID_PKG_DESCRIPTION="Programs providing a simple interface to inotify"
LINUXDROID_PKG_VERSION=3.20.1
LINUXDROID_PKG_SHA256=a433cc1dedba851078276db69b0e97f9fe41e4ba3336d2971adfca4b3a6242ac
LINUXDROID_PKG_SRCURL=https://github.com/rvoicilas/inotify-tools/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	./autogen.sh

	LDFLAGS+=" -llog"
}

linuxdroid_step_make () {
	:
}

linuxdroid_step_make_install () {
	# the command-line tools needs the libinotifytools installed before building
	make -C libinotifytools install
	make install
}
