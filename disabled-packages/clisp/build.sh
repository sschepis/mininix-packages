MININIX_PKG_HOMEPAGE=http://www.clisp.org/
MININIX_PKG_DESCRIPTION="GNU CLISP - an ANSI Common Lisp Implementation"
MININIX_PKG_VERSION=2.49
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/clisp/clisp/${MININIX_PKG_VERSION}/clisp-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="readline, libandroid-support"
MININIX_MAKE_PROCESSES=1

mininix_step_configure () {
	cd $MININIX_PKG_BUILDDIR

	export XCPPFLAGS="$CPPFLAGS"
	export XCFLAGS="$CFLAGS"
	export XLDFLAGS="$LDFLAGS"

	unset CC
	unset CPPFLAGS
	unset CFLAGS
	unset LDFLAGS

	$MININIX_PKG_SRCDIR/configure \
		--host=$MININIX_HOST_PLATFORM \
		--prefix=$MININIX_PREFIX \
		--enable-shared \
		--disable-static \
		--srcdir=$MININIX_PKG_SRCDIR \
		--ignore-absence-of-libsigsegv \
		ac_cv_func_select=yes
}
