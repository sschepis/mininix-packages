LINUXDROID_PKG_HOMEPAGE=http://rephial.org/
LINUXDROID_PKG_DESCRIPTION="Dungeon exploration adventure game"
LINUXDROID_PKG_VERSION=4.1.3
LINUXDROID_PKG_SHA256=9402c4f8da691edbd4567a948c5663e1066bee3fcb4a62fbcf86b5454918406f
LINUXDROID_PKG_SRCURL=http://rephial.org/downloads/4.1/angband-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11 --bindir=$LINUXDROID_PREFIX/bin --sysconfdir=$LINUXDROID_PREFIX/share/angband"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/angband/xtra share/angband/icons"

linuxdroid_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}

linuxdroid_step_post_make_install () {
	rm -Rf $LINUXDROID_PREFIX/share/angband/{fonts,sounds}
}
