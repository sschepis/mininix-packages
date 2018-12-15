MININIX_PKG_HOMEPAGE=https://mosh.org
MININIX_PKG_DESCRIPTION="Mobile shell that supports roaming and intelligent local echo"
MININIX_PKG_VERSION=1.3.2
MININIX_PKG_REVISION=7
MININIX_PKG_SHA256=da600573dfa827d88ce114e0fed30210689381bbdcff543c931e4d6a2e851216
MININIX_PKG_SRCURL=https://github.com/mobile-shell/mosh/releases/download/mosh-${MININIX_PKG_VERSION}/mosh-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, libprotobuf, ncurses, openssl, openssh, libutil"

mininix_step_pre_configure () {
	export PROTOC=$MININIX_TOPDIR/libprotobuf/host-build/src/protoc
	CXXFLAGS+=" -std=c++11" # Required by protobuf.
}

mininix_step_post_make_install () {
	cd $MININIX_PREFIX/bin
	mv mosh mosh.pl
	$CXX $CXXFLAGS $LDFLAGS \
		-isystem $MININIX_PREFIX/include \
		-lutil \
		-DPACKAGE_VERSION=\"$MININIX_PKG_VERSION\" \
		-std=c++11 -Wall -Wextra -Werror \
		$MININIX_PKG_BUILDER_DIR/mosh.cc -o mosh
}
