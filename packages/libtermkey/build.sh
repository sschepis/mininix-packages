LINUXDROID_PKG_HOMEPAGE=http://www.leonerd.org.uk/code/libtermkey/
LINUXDROID_PKG_DESCRIPTION="Library for processing of keyboard entry for terminal-based programs"
LINUXDROID_PKG_VERSION=0.20
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://www.leonerd.org.uk/code/libtermkey/libtermkey-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=6c0d87c94ab9915e76ecd313baec08dedf3bd56de83743d9aa923a081935d2f5
LINUXDROID_PKG_DEPENDS="libunibilium"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make () {
	return
}

linuxdroid_step_make_install () {
	CFLAGS+=" -std=c99 -DHAVE_UNIBILIUM=1"
	$CC $CFLAGS $CPPFLAGS -c -fPIC termkey.c -o termkey.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-csi.c -o driver-csi.o
	$CC $CFLAGS $CPPFLAGS -c -fPIC driver-ti.c -o driver-ti.o

	$CC -shared -fPIC $LDFLAGS -o $LINUXDROID_PREFIX/lib/libtermkey.so termkey.o driver-csi.o driver-ti.o -lunibilium

	chmod u+w termkey.h
	cp termkey.h $LINUXDROID_PREFIX/include/
	cat termkey.pc.in | sed "s|@INCDIR@|$LINUXDROID_PREFIX/include|" | \
	                    sed "s|@LIBDIR@|$LINUXDROID_PREFIX/lib|" > \
			    $PKG_CONFIG_LIBDIR/termkey.pc
}
