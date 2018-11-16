LINUXDROID_PKG_HOMEPAGE=https://github.com/librsync/librsync
LINUXDROID_PKG_DESCRIPTION="Remote delta-compression library"
LINUXDROID_PKG_VERSION=2.0.2
LINUXDROID_PKG_SHA256=e67b9520ee84f7239be6e948795803bd95495091cc00bf6d0e8c6976032a4af1
LINUXDROID_PKG_SRCURL=https://github.com/librsync/librsync/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libbz2"
LINUXDROID_PKG_BUILD_DEPENDS="libpopt"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="-DPERL_EXECUTABLE=`which perl`"

linuxdroid_step_pre_configure () {
	# Remove old files to ensure new timestamps on symlinks:
	rm -Rf $LINUXDROID_PREFIX/lib/librsync.*
}

linuxdroid_step_post_configure () {
	mkdir -p $LINUXDROID_PREFIX/share/man/man{1,3}
	cp $LINUXDROID_PKG_SRCDIR/doc/rdiff.1 $LINUXDROID_PREFIX/share/man/man1
	cp $LINUXDROID_PKG_SRCDIR/doc/librsync.3 $LINUXDROID_PREFIX/share/man/man3
}
