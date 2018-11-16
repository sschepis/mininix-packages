LINUXDROID_PKG_HOMEPAGE=http://www.doxygen.org
LINUXDROID_PKG_DESCRIPTION="A documentation system for C++, C, Java, IDL and PHP"
LINUXDROID_PKG_VERSION=1.8.14
LINUXDROID_PKG_MAINTAINER="lokesh @hax4us"
LINUXDROID_PKG_SHA256=d1757e02755ef6f56fd45f1f4398598b920381948d6fcfa58f5ca6aa56f59d4d
LINUXDROID_PKG_SRCURL=http://ftp.stack.nl/pub/doxygen/doxygen-${LINUXDROID_PKG_VERSION}.src.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=`which bison`
-Dbuild_parse=yes
-Dbuild_xmlparser=yes
-DCMAKE_BUILD_TYPE=Release
-DFLEX_EXECUTABLE=`which flex`
"
linuxdroid_step_post_make_install () {
	mkdir -p $LINUXDROID_PREFIX/share/man/man1
	cp $LINUXDROID_PKG_SRCDIR/doc/doxygen.1 $LINUXDROID_PREFIX/share/man/man1
}
