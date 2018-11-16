LINUXDROID_PKG_HOMEPAGE=https://www.mirbsd.org/jupp.htm
LINUXDROID_PKG_DESCRIPTION="User friendly full screen text editor"
LINUXDROID_PKG_MAINTAINER="Dominik George @Natureshadow"
LINUXDROID_PKG_DEPENDS="ncurses, libutil"
LINUXDROID_PKG_CONFLICTS="joe"
LINUXDROID_PKG_VERSION=3.1jupp37
LINUXDROID_PKG_SHA256=7755480792026b4eedc1ed5abe3f771ace85d402195a658d4bd3a9e9cdd8f11b
LINUXDROID_PKG_SRCURL=http://www.mirbsd.org/MirOS/dist/jupp/joe-${LINUXDROID_PKG_VERSION}.tgz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dependency-tracking
--disable-getpwnam
--disable-termcap
--disable-termidx
--enable-sysconfjoesubdir=/jupp
"

linuxdroid_step_post_extract_package() {
	chmod +x $LINUXDROID_PKG_SRCDIR/configure
}
