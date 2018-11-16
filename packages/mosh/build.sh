LINUXDROID_PKG_HOMEPAGE=https://mosh.org
LINUXDROID_PKG_DESCRIPTION="Mobile shell that supports roaming and intelligent local echo"
LINUXDROID_PKG_VERSION=1.3.2
LINUXDROID_PKG_REVISION=7
LINUXDROID_PKG_SHA256=da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216
LINUXDROID_PKG_SRCURL=https://github.com/mobile-shell/mosh/releases/download/mosh-${LINUXDROID_PKG_VERSION}/mosh-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, libprotobuf, ncurses, openssl, openssh, libutil"

linuxdroid_step_pre_configure () {
	export PROTOC=$LINUXDROID_TOPDIR/libprotobuf/host-build/src/protoc
	CXXFLAGS+=" -std=c++11" # Required by protobuf.
}

linuxdroid_step_post_make_install () {
	cd $LINUXDROID_PREFIX/bin
	mv mosh mosh.pl
	$CXX $CXXFLAGS $LDFLAGS \
		-isystem $LINUXDROID_PREFIX/include \
		-lutil \
		-DPACKAGE_VERSION=\"$LINUXDROID_PKG_VERSION\" \
		-std=c++11 -Wall -Wextra -Werror \
		$LINUXDROID_PKG_BUILDER_DIR/mosh.cc -o mosh
}
