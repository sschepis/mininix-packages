LINUXDROID_PKG_HOMEPAGE=http://p7zip.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="Command-line version of the 7zip compressed file archiver"
LINUXDROID_PKG_MAINTAINER="Francisco Demartino @franciscod"
LINUXDROID_PKG_VERSION=16.02
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/project/p7zip/p7zip/${LINUXDROID_PKG_VERSION}/p7zip_${LINUXDROID_PKG_VERSION}_src_all.tar.bz2
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure () {
	export CXXFLAGS="$CXXFLAGS -Wno-c++11-narrowing"
	cp makefile.android_arm makefile.machine
}

linuxdroid_step_make () {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		make -j $LINUXDROID_MAKE_PROCESSES all3 OPTFLAGS="${CXXFLAGS}" DEST_HOME=$LINUXDROID_PREFIX
}

linuxdroid_step_make_install () {
	make install DEST_HOME=$LINUXDROID_PREFIX DEST_MAN=$LINUXDROID_PREFIX/share/man
}
