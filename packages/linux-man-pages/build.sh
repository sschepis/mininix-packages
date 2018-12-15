MININIX_PKG_HOMEPAGE=https://www.kernel.org/doc/man-pages/
MININIX_PKG_DESCRIPTION="Man pages for linux kernel and C library interfaces"
MININIX_PKG_VERSION=(4.16
		    2013)
MININIX_PKG_SHA256=(47ffcc0d27d50e497e290b27e8d76dbed4550db14c881f25b771bcaf28354db4
		   19633a5c75ff7deab35b1d2c3d5b7748e7bd4ef4ab598b647bb7e7f60b90a808)
MININIX_PKG_SRCURL=(https://www.kernel.org/pub/linux/docs/man-pages/man-pages-${MININIX_PKG_VERSION}.tar.xz
		   https://www.kernel.org/pub/linux/docs/man-pages/man-pages-posix/man-pages-posix-${MININIX_PKG_VERSION[1]}-a.tar.xz)
MININIX_PKG_DEPENDS="man"
MININIX_PKG_EXTRA_MAKE_ARGS="prefix=$MININIX_PREFIX"
# man.7 and mdoc.7 is included with mandoc:
# getconf man page included with the getconf package:
MININIX_PKG_RM_AFTER_INSTALL="share/man/man1 share/man/man8 share/man/man7/man.7 share/man/man7/mdoc.7 share/man/man1p/getconf.1p"
MININIX_PKG_PLATFORM_INDEPENDENT=true
MININIX_PKG_BUILD_IN_SRC=true
# Problems with changing permissions of non-built files
MININIX_MAKE_PROCESSSES=1

mininix_step_pre_configure() {
	# Bundle posix man pages in same package:
	cd man-pages-posix-2013-a
	make install
}
