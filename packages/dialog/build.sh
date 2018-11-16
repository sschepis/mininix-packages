LINUXDROID_PKG_HOMEPAGE=http://invisible-island.net/dialog/
LINUXDROID_PKG_DESCRIPTION="Application used in shell scripts which displays text user interface widgets"
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_VERSION="1.3-20181107"
LINUXDROID_PKG_SHA256=efeaca8027dda53a9f3cf6c7b5c1a77093825b7a9b85c23c0c6c96afc3506457
LINUXDROID_PKG_SRCURL=http://invisible-island.net/datafiles/release/dialog.tar.gz
# This will break when a new version is released (the URL unfortunately does not change)
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-ncursesw --enable-widec --with-pkg-config"

linuxdroid_step_pre_configure () {
	# Put a temporary link for libtinfo.so
	ln -s -f $LINUXDROID_PREFIX/lib/libncursesw.so $LINUXDROID_PREFIX/lib/libtinfo.so
}

linuxdroid_step_post_make_install () {
	rm $LINUXDROID_PREFIX/lib/libtinfo.so
	cd $LINUXDROID_PREFIX/bin
	ln -f -s dialog whiptail
}
