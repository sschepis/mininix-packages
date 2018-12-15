MININIX_PKG_HOMEPAGE=https://github.com/librsync/librsync
MININIX_PKG_DESCRIPTION="Remote delta-compression library"
MININIX_PKG_VERSION=2.0.2
MININIX_PKG_SHA256=e67b9520ee84f7239be6e948795803bd95495091cc00bf6d0e8c6976032a4af1
MININIX_PKG_SRCURL=https://github.com/librsync/librsync/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libbz2"
MININIX_PKG_BUILD_DEPENDS="libpopt"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="-DPERL_EXECUTABLE=`which perl`"

mininix_step_pre_configure () {
	# Remove old files to ensure new timestamps on symlinks:
	rm -Rf $MININIX_PREFIX/lib/librsync.*
}

mininix_step_post_configure () {
	mkdir -p $MININIX_PREFIX/share/man/man{1,3}
	cp $MININIX_PKG_SRCDIR/doc/rdiff.1 $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_SRCDIR/doc/librsync.3 $MININIX_PREFIX/share/man/man3
}
