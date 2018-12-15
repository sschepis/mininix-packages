MININIX_PKG_HOMEPAGE=http://rephial.org/
MININIX_PKG_DESCRIPTION="Dungeon exploration adventure game"
MININIX_PKG_VERSION=4.1.3
MININIX_PKG_SHA256=9402c4f8da691edbd4567a948c5663e1066bee3fcb4a62fbcf86b5454918406f
MININIX_PKG_SRCURL=http://rephial.org/downloads/4.1/angband-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11 --bindir=$MININIX_PREFIX/bin --sysconfdir=$MININIX_PREFIX/share/angband"
MININIX_PKG_RM_AFTER_INSTALL="share/angband/xtra share/angband/icons"

mininix_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}

mininix_step_post_make_install () {
	rm -Rf $MININIX_PREFIX/share/angband/{fonts,sounds}
}
