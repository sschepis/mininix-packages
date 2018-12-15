MININIX_PKG_HOMEPAGE=http://www.leonerd.org.uk/code/libtermkey/
MININIX_PKG_DESCRIPTION="Library for processing of keyboard entry for terminal-based programs"
MININIX_PKG_VERSION=0.20
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=http://www.leonerd.org.uk/code/libtermkey/libtermkey-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=6c0d87c94ab9915e76ecd313baec08dedf3bd56de83743d9aa923a081935d2f5
MININIX_PKG_DEPENDS="libunibilium"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make () {
	return
}

mininix_step_make_install () {
	CFLAGS+=" -std=c99 -DHAVE_UNIBILIUM=1"
	$CC $CFLAGS $CPPFLAGS -c -fPIC termkey.c -o termkey.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-csi.c -o driver-csi.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-ti.c -o driver-ti.o

	$CC -shared -fPIC $LDFLAGS -o $MININIX_PREFIX/lib/libtermkey.so termkey.o driver-csi.o driver-ti.o -lunibilium

	chmod u+w termkey.h
	cp termkey.h $MININIX_PREFIX/include/
	cat termkey.pc.in | sed "s|@INCDIR@|$MININIX_PREFIX/include|" | \
	                    sed "s|@LIBDIR@|$MININIX_PREFIX/lib|" > \
			    $PKG_CONFIG_LIBDIR/termkey.pc
}
