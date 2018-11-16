LINUXDROID_PKG_HOMEPAGE=http://www.clisp.org/
LINUXDROID_PKG_DESCRIPTION="GNU CLISP - an ANSI Common Lisp Implementation"
LINUXDROID_PKG_VERSION=2.49
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/clisp/clisp/${LINUXDROID_PKG_VERSION}/clisp-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="readline, libandroid-support"
LINUXDROID_MAKE_PROCESSES=1

linuxdroid_step_configure () {
	cd $LINUXDROID_PKG_BUILDDIR

	export XCPPFLAGS="$CPPFLAGS"
	export XCFLAGS="$CFLAGS"
	export XLDFLAGS="$LDFLAGS"

	unset CC
	unset CPPFLAGS
	unset CFLAGS
	unset LDFLAGS

	$LINUXDROID_PKG_SRCDIR/configure \
		--host=$LINUXDROID_HOST_PLATFORM \
		--prefix=$LINUXDROID_PREFIX \
		--enable-shared \
		--disable-static \
		--srcdir=$LINUXDROID_PKG_SRCDIR \
		--ignore-absence-of-libsigsegv \
		ac_cv_func_select=yes
}
