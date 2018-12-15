MININIX_PKG_HOMEPAGE=https://www.mirbsd.org/jupp.htm
MININIX_PKG_DESCRIPTION="User friendly full screen text editor"
MININIX_PKG_MAINTAINER="Dominik George @Natureshadow"
MININIX_PKG_DEPENDS="ncurses, libutil"
MININIX_PKG_CONFLICTS="joe"
MININIX_PKG_VERSION=3.1jupp38
MININIX_PKG_SHA256=c5cbe3f97683f6e513f611a60531feefb9b877f8cea4c6e9087b48631f69ed40
MININIX_PKG_SRCURL=http://www.mirbsd.org/MirOS/dist/jupp/joe-${MININIX_PKG_VERSION}.tgz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dependency-tracking
--disable-getpwnam
--disable-termcap
--disable-termidx
--enable-sysconfjoesubdir=/jupp
"

mininix_step_post_extract_package() {
	chmod +x $MININIX_PKG_SRCDIR/configure
}
