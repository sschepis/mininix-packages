LINUXDROID_PKG_HOMEPAGE=http://www.brain-dump.org/projects/abduco/
LINUXDROID_PKG_DESCRIPTION="Clean and simple terminal session manager"
LINUXDROID_PKG_VERSION=0.6
LINUXDROID_PKG_SRCURL=http://www.brain-dump.org/projects/abduco/abduco-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=c90909e13fa95770b5afc3b59f311b3d3d2fdfae23f9569fa4f96a3e192a35f4
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="libutil,dvtm"

linuxdroid_step_pre_configure () {
	CFLAGS+=" $CPPFLAGS"
}
