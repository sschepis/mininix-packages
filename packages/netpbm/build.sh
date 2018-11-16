LINUXDROID_PKG_HOMEPAGE=http://netpbm.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="Toolkit for manipulation of graphic images of different formats"
# The netpbm releases are described at http://netpbm.sourceforge.net/release.html
# and are divided among (1) Development, (2) Advanced, (3) Stable and (4) Super Stable.
# Only Super Stable is distributed as a tar ball, but is outdated and does not compile with modern libpng.
# So use revisions from http://svn.code.sf.net/p/netpbm/code/advanced for packages.
LINUXDROID_PKG_VERSION=3094
LINUXDROID_PKG_SHA256=2f4d8c245f174e391a4cf2418075c06532aee8a5fcc8dbbb8f2e7012cd9d52a4
LINUXDROID_PKG_SRCURL=https://dl.bintray.com/linuxdroid/upstream/netpbm-advanced-r${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libpng, libxml2, libjpeg-turbo, libtiff"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure () {
	# Put the android libpng-config script in the path (before the host one):
	LINUXDROID_PKG_LIBPNG_CONFIG_DIR=$LINUXDROID_PKG_TMPDIR/libpng-config
	mkdir -p $LINUXDROID_PKG_LIBPNG_CONFIG_DIR
	cp $LINUXDROID_PREFIX/bin/libpng-config $LINUXDROID_PKG_LIBPNG_CONFIG_DIR/
	export PATH=$LINUXDROID_PKG_LIBPNG_CONFIG_DIR:$PATH

	# See $SRC/doc/INSTALL about netpbm build system. For automatic builds it recommends just copying config.mk.in
	cd $LINUXDROID_PKG_SRCDIR
	cp config.mk.in config.mk
	echo "AR = $AR" >> config.mk
	echo "RANLIB = $RANLIB" >> config.mk
	echo "CC = $CC" >> config.mk
	echo "CFLAGS = $CFLAGS" >> config.mk
	echo "CFLAGS_SHLIB = -fPIC" >> config.mk
	echo "LDFLAGS = $LDFLAGS" >> config.mk
	echo "STATICLIB_TOO = n" >> config.mk
	echo "INTTYPES_H = <inttypes.h>" >> config.mk
	export STRIPPROG=$STRIP

	echo "CC_FOR_BUILD = cc" >> config.mk
	echo "LD_FOR_BUILD = cc" >> config.mk
	echo "CFLAGS_FOR_BUILD = " >> config.mk
	echo "LDFLAGS_FOR_BUILD = " >> config.mk
	echo "JPEGLIB = ${LINUXDROID_PREFIX}/lib/libjpeg.so" >> config.mk
	echo "TIFFLIB = ${LINUXDROID_PREFIX}/lib/libtiff.so" >> config.mk
	echo "TIFFLIB_NEEDS_Z = N" >> config.mk

	cp $LINUXDROID_PKG_BUILDER_DIR/standardppmdfont.c lib/
}

linuxdroid_step_make_install () {
	rm -Rf /tmp/netpbm
	make -j 1 package pkgdir=/tmp/netpbm
	./installnetpbm
}
