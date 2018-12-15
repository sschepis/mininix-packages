MININIX_PKG_HOMEPAGE=http://www.brain-dump.org/projects/abduco/
MININIX_PKG_DESCRIPTION="Clean and simple terminal session manager"
MININIX_PKG_VERSION=0.6
MININIX_PKG_SRCURL=http://www.brain-dump.org/projects/abduco/abduco-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=c90909e13fa95770b5afc3b59f311b3d3d2fdfae23f9569fa4f96a3e192a35f4
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="libutil,dvtm"

mininix_step_pre_configure () {
	CFLAGS+=" $CPPFLAGS"
}
