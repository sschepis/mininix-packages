MININIX_PKG_HOMEPAGE=https://dev.yorhel.nl/ncdc
MININIX_PKG_DESCRIPTION="Modern and lightweight direct connect client with a friendly ncurses interface"
MININIX_PKG_VERSION=1.20
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://dev.yorhel.nl/download/ncdc-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=8a998857df6289b6bd44287fc06f705b662098189f2a8fe95b1a5fbc703b9631
MININIX_PKG_DEPENDS="libandroid-support, libgnutls, libsqlite, bzip2, glib, ncurses"
MININIX_PKG_BUILD_DEPENDS="libbz2-dev, libnettle-dev, libidn-dev"
MININIX_PKG_BUILD_IN_SRC="yes"

mininix_step_post_configure () {
	# Cross compiling steps documented in ncdc README
	gcc $MININIX_PKG_SRCDIR/deps/makeheaders.c -o makeheaders
	gcc -I. $MININIX_PKG_SRCDIR/doc/gendoc.c -o gendoc
	touch -d "next hour" makeheaders gendoc
}
