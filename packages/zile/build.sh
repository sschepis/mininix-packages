MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/zile/
MININIX_PKG_DESCRIPTION="Lightweight clone of the Emacs text editor"
MININIX_PKG_MAINTAINER="Iain Nicol @iainnicol"
MININIX_PKG_VERSION=2.4.14
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/zile/zile-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=7a78742795ca32480f2bab697fd5e328618d9997d6f417cf1b14e9da9af26b74
MININIX_PKG_DEPENDS="libgc, ncurses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_configure() {
	# zile uses help2man to build the zile.1 man page, which would require
	# a host build. To avoid that just copy a pre-built man page.
	cp $MININIX_PKG_BUILDER_DIR/zile.1 $MININIX_PKG_BUILDDIR/doc/zile.1
	touch -d "next hour" $MININIX_PKG_BUILDDIR/doc/zile.1*
}
