LINUXDROID_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdc
LINUXDROID_PKG_DESCRIPTION="Modern and lightweight direct connect client with a friendly ncurses interface"
LINUXDROID_PKG_VERSION=1.20
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://dev.yorhel.nl/download/ncdc-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=8a998857df6289b6bd44287fc06f705b662098189f2a8fe95b1a5fbc703b9631
LINUXDROID_PKG_DEPENDS="libandroid-support, libgnutls, libsqlite, bzip2, glib, ncurses"
LINUXDROID_PKG_BUILD_DEPENDS="libbz2-dev, libnettle-dev, libidn-dev"
LINUXDROID_PKG_BUILD_IN_SRC="yes"

linuxdroid_step_post_configure () {
	# Cross compiling steps documented in ncdc README
	gcc $LINUXDROID_PKG_SRCDIR/deps/makeheaders.c -o makeheaders
	gcc -I. $LINUXDROID_PKG_SRCDIR/doc/gendoc.c -o gendoc
	touch -d "next hour" makeheaders gendoc
}
