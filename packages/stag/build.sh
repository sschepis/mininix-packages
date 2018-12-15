MININIX_PKG_HOMEPAGE=https://github.com/seenaburns/stag
MININIX_PKG_DESCRIPTION="Streaming bar graphs. For stats and stuff."
MININIX_PKG_VERSION=1.0.0
MININIX_PKG_SRCURL=https://github.com/seenaburns/stag/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=391574e6aa12856d5a598a374e3a40a38cbab6ef9d769c0d59af8411b4fbecb6
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CFLAGS+=" $LDFLAGS"
}
