MININIX_PKG_HOMEPAGE=http://p7zip.sourceforge.net/
MININIX_PKG_DESCRIPTION="Command-line version of the 7zip compressed file archiver"
MININIX_PKG_MAINTAINER="Francisco Demartino @franciscod"
MININIX_PKG_VERSION=16.02
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/p7zip/p7zip/${MININIX_PKG_VERSION}/p7zip_${MININIX_PKG_VERSION}_src_all.tar.bz2
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_configure () {
	export CXXFLAGS="$CXXFLAGS -Wno-c++11-narrowing"
	cp makefile.android_arm makefile.machine
}

mininix_step_make () {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		make -j $MININIX_MAKE_PROCESSES all3 OPTFLAGS="${CXXFLAGS}" DEST_HOME=$MININIX_PREFIX
}

mininix_step_make_install () {
	make install DEST_HOME=$MININIX_PREFIX DEST_MAN=$MININIX_PREFIX/share/man
}
