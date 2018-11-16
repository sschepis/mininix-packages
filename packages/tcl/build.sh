LINUXDROID_PKG_HOMEPAGE=https://www.tcl.tk/
LINUXDROID_PKG_DESCRIPTION="Powerful but easy to learn dynamic programming language"
LINUXDROID_PKG_DEPENDS="libsqlite"
LINUXDROID_PKG_VERSION=8.6.8
LINUXDROID_PKG_SHA256=c43cb0c1518ce42b00e7c8f6eaddd5195c53a98f94adc717234a65cbcfd3f96a
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/project/tcl/Tcl/${LINUXDROID_PKG_VERSION}/tcl${LINUXDROID_PKG_VERSION}-src.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_memcmp_working=yes
ac_cv_func_memcmp=yes
ac_cv_func_strtod=yes
ac_cv_func_strtoul=yes
tcl_cv_strstr_unbroken=ok
tcl_cv_strtod_buggy=ok
tcl_cv_strtod_unbroken=ok
tcl_cv_strtoul_unbroken=ok
--disable-rpath
--enable-man-symlinks
--mandir=$LINUXDROID_PREFIX/share/man
"

linuxdroid_step_pre_configure () {
	LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_SRCDIR/unix
	CFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD"
}

linuxdroid_step_post_make_install () {
	# expect needs private headers
	make install-private-headers
	local _MAJOR_VERSION=${LINUXDROID_PKG_VERSION:0:3}
	cd $LINUXDROID_PREFIX/bin
	ln -f -s tclsh$_MAJOR_VERSION tclsh

	# Hack to use system libsqlite (https://www.sqlite.org/howtocompile.html#tcl)
	# since --with-system-sqlite fails to build:
	local NEW_LIBDIR=$LINUXDROID_PREFIX/lib/tcl$_MAJOR_VERSION/sqlite
	mkdir -p $NEW_LIBDIR
	$CC $CFLAGS $CPPFLAGS $LDFLAGS \
		-DUSE_SYSTEM_SQLITE=1 \
		-o $NEW_LIBDIR/libtclsqlite3.so \
		-shared \
		$LINUXDROID_PREFIX/src/libsqlite/tclsqlite3.c \
		-ltcl$_MAJOR_VERSION -lsqlite3
	local LIBSQLITE_VERSION=`$PKG_CONFIG --modversion sqlite3`
	echo "package ifneeded sqlite3 $LIBSQLITE_VERSION [list load [file join \$dir libtclsqlite3.so] Sqlite3]" > \
		$NEW_LIBDIR/pkgIndex.tcl
}
