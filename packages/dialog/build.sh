MININIX_PKG_HOMEPAGE=http://invisible-island.net/dialog/
MININIX_PKG_DESCRIPTION="Application used in shell scripts which displays text user interface widgets"
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_VERSION="1.3-20181107"
MININIX_PKG_SHA256=efeaca8027dda53a9f3cf6c7b5c1a77093825b7a9b85c23c0c6c96afc3506457
MININIX_PKG_SRCURL=http://invisible-island.net/datafiles/release/dialog.tar.gz
# This will break when a new version is released (the URL unfortunately does not change)
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-ncursesw --enable-widec --with-pkg-config"

mininix_step_pre_configure () {
	# Put a temporary link for libtinfo.so
	ln -s -f $MININIX_PREFIX/lib/libncursesw.so $MININIX_PREFIX/lib/libtinfo.so
}

mininix_step_post_make_install () {
	rm $MININIX_PREFIX/lib/libtinfo.so
	cd $MININIX_PREFIX/bin
	ln -f -s dialog whiptail
}
