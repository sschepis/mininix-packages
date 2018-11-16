LINUXDROID_PKG_HOMEPAGE=https://github.com/seenaburns/stag
LINUXDROID_PKG_DESCRIPTION="Streaming bar graphs. For stats and stuff."
LINUXDROID_PKG_VERSION=1.0.0
LINUXDROID_PKG_SRCURL=https://github.com/seenaburns/stag/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=391574e6aa12856d5a598a374e3a40a38cbab6ef9d769c0d59af8411b4fbecb6
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CFLAGS+=" $LDFLAGS"
}
