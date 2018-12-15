MININIX_PKG_HOMEPAGE=https://github.com/google/protobuf
MININIX_PKG_DESCRIPTION="Protocol buffers C++ library"
MININIX_PKG_VERSION=3.6.1
MININIX_PKG_SHA256=3d4e589d81b2006ca603c1ab712c9715a76227293032d05b26fca603f90b3f5b
MININIX_PKG_SRCURL=https://github.com/google/protobuf/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_HOSTBUILD=yes
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-protoc=$MININIX_PKG_HOSTBUILD_DIR/src/protoc"
# We extracted libprotobuf from protobuf earlier:
MININIX_PKG_CONFLICTS="protobuf (<= 3.0.0)"

mininix_step_host_build() {
	"$MININIX_PKG_SRCDIR/configure" --prefix=$MININIX_PKG_HOSTBUILD_DIR/install
	# We install protobuf so that libgrpc can use it in a hackish way:
	make -j $MININIX_MAKE_PROCESSES install
}

mininix_step_post_extract_package () {
	./autogen.sh
}
