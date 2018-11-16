LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/zile/
LINUXDROID_PKG_DESCRIPTION="Lightweight clone of the Emacs text editor"
LINUXDROID_PKG_MAINTAINER="Iain Nicol @iainnicol"
LINUXDROID_PKG_VERSION=2.4.14
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/zile/zile-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=7a78742795ca32480f2bab697fd5e328618d9997d6f417cf1b14e9da9af26b74
LINUXDROID_PKG_DEPENDS="libgc, ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_configure() {
	# zile uses help2man to build the zile.1 man page, which would require
	# a host build. To avoid that just copy a pre-built man page.
	cp $LINUXDROID_PKG_BUILDER_DIR/zile.1 $LINUXDROID_PKG_BUILDDIR/doc/zile.1
	touch -d "next hour" $LINUXDROID_PKG_BUILDDIR/doc/zile.1*
}
