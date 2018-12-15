MININIX_PKG_HOMEPAGE=https://www.tcl.tk/
MININIX_PKG_DESCRIPTION="Powerful but easy to learn dynamic programming language"
MININIX_PKG_DEPENDS="libsqlite"
MININIX_PKG_VERSION=8.6.9
MININIX_PKG_SHA256=ad0cd2de2c87b9ba8086b43957a0de3eb2eb565c7159d5f53ccbba3feb915f4e
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/tcl/Tcl/${MININIX_PKG_VERSION}/tcl${MININIX_PKG_VERSION}-src.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
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
--mandir=$MININIX_PREFIX/share/man
"

mininix_step_pre_configure () {
	MININIX_PKG_SRCDIR=$MININIX_PKG_SRCDIR/unix
	CFLAGS+=" -DBIONIC_IOCTL_NO_SIGNEDNESS_OVERLOAD"
}

mininix_step_post_make_install () {
	# expect needs private headers
	make install-private-headers
	local _MAJOR_VERSION=${MININIX_PKG_VERSION:0:3}
	cd $MININIX_PREFIX/bin
	ln -f -s tclsh$_MAJOR_VERSION tclsh

	# Hack to use system libsqlite (https://www.sqlite.org/howtocompile.html#tcl)
	# since --with-system-sqlite fails to build:
	local NEW_LIBDIR=$MININIX_PREFIX/lib/tcl$_MAJOR_VERSION/sqlite
	mkdir -p $NEW_LIBDIR
	$CC $CFLAGS $CPPFLAGS $LDFLAGS \
		-DUSE_SYSTEM_SQLITE=1 \
		-o $NEW_LIBDIR/libtclsqlite3.so \
		-shared \
		$MININIX_PREFIX/src/libsqlite/tclsqlite3.c \
		-ltcl$_MAJOR_VERSION -lsqlite3
	local LIBSQLITE_VERSION=`$PKG_CONFIG --modversion sqlite3`
	echo "package ifneeded sqlite3 $LIBSQLITE_VERSION [list load [file join \$dir libtclsqlite3.so] Sqlite3]" > \
		$NEW_LIBDIR/pkgIndex.tcl
}
