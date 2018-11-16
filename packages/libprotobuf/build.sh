LINUXDROID_PKG_HOMEPAGE=https://github.com/google/protobuf
LINUXDROID_PKG_DESCRIPTION="Protocol buffers C++ library"
LINUXDROID_PKG_VERSION=3.6.1
LINUXDROID_PKG_SHA256=3d4e589d81b2006ca603c1ab712c9715a76227293032d05b26fca603f90b3f5b
LINUXDROID_PKG_SRCURL=https://github.com/google/protobuf/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_HOSTBUILD=yes
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-protoc=$LINUXDROID_PKG_HOSTBUILD_DIR/src/protoc"
# We extracted libprotobuf from protobuf earlier:
LINUXDROID_PKG_CONFLICTS="protobuf (<= 3.0.0)"

linuxdroid_step_host_build() {
	"$LINUXDROID_PKG_SRCDIR/configure" --prefix=$LINUXDROID_PKG_HOSTBUILD_DIR/install
	# We install protobuf so that libgrpc can use it in a hackish way:
	make -j $LINUXDROID_MAKE_PROCESSES install
}

linuxdroid_step_post_extract_package () {
	./autogen.sh
}
