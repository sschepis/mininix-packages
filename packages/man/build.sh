LINUXDROID_PKG_HOMEPAGE=https://mdocml.bsd.lv/
LINUXDROID_PKG_DESCRIPTION="Man page viewer from the mandoc toolset"
LINUXDROID_PKG_VERSION=1.14.4
LINUXDROID_PKG_SHA256=24eb72103768987dcc63b53d27fdc085796330782f44b3b40c4660b1e1ee9b9c
LINUXDROID_PKG_SRCURL=http://mdocml.bsd.lv/snapshots/mandoc-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="less,libandroid-glob"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_RM_AFTER_INSTALL="share/examples"

linuxdroid_step_pre_configure () {
	LDFLAGS+=" -landroid-glob"
	echo "PREFIX=\"$LINUXDROID_PREFIX\"" > configure.local
	echo "CC=\"$CC\"" >> configure.local
	echo "MANDIR=\"$LINUXDROID_PREFIX/share/man\"" >> configure.local
	echo "CFLAGS=\"$CFLAGS -std=c99 -DNULL=0 $CPPFLAGS\"" >> configure.local
	echo "LDFLAGS=\"$LDFLAGS\"" >> configure.local
	for HAVING in HAVE_FGETLN HAVE_MMAP HAVE_STRLCAT HAVE_STRLCPY HAVE_SYS_ENDIAN HAVE_ENDIAN HAVE_NTOHL HAVE_NANOSLEEP HAVE_O_DIRECTORY; do
		echo "$HAVING=1" >> configure.local
	done
	echo "HAVE_MANPATH=0" >> configure.local
	echo "HAVE_SQLITE3=1" >> configure.local
}

linuxdroid_step_create_debscripts () {
	echo "interest-noawait $LINUXDROID_PREFIX/share/man" > triggers
	
	echo "#!$LINUXDROID_PREFIX/bin/sh" >> postinst
	echo "makewhatis -Q" >> postinst
	echo "exit 0" >> postinst
}
