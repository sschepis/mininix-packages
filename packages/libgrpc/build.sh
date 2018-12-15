MININIX_PKG_HOMEPAGE=https://grpc.io/
MININIX_PKG_DESCRIPTION="High performance, open source, general RPC framework that puts mobile and HTTP/2 first"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_VERSION=1.16.1
MININIX_PKG_DEPENDS="openssl, protobuf, c-ares"
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_STRIP=`which strip`
-DGIT_EXECUTABLE=`which git`
-DBUILD_SHARED_LIBS=ON
-DgRPC_CARES_PROVIDER=package
-DgRPC_PROTOBUF_PROVIDER=package
-DgRPC_SSL_PROVIDER=package
-DgRPC_ZLIB_PROVIDER=package
-DProtobuf_PROTOC_EXECUTABLE=$MININIX_TOPDIR/libprotobuf/host-build/src/protoc
-DRUN_HAVE_POSIX_REGEX=0
-DRUN_HAVE_STD_REGEX=0
-DRUN_HAVE_STEADY_CLOCK=0
"

mininix_step_extract_package() {
	local CHECKED_OUT_FOLDER=$MININIX_PKG_CACHEDIR/checkout-$MININIX_PKG_VERSION
	if [ ! -d $CHECKED_OUT_FOLDER ]; then
		local TMP_CHECKOUT=$MININIX_PKG_TMPDIR/tmp-checkout
		rm -Rf $TMP_CHECKOUT
		mkdir -p $TMP_CHECKOUT

		git clone --depth 1 \
			--branch v$MININIX_PKG_VERSION \
			https://github.com/grpc/grpc.git \
			$TMP_CHECKOUT
		cd $TMP_CHECKOUT
		git submodule update --init # --depth 1
		mv $TMP_CHECKOUT $CHECKED_OUT_FOLDER
	fi

	mkdir $MININIX_PKG_SRCDIR
	cd $MININIX_PKG_SRCDIR
	cp -Rf $CHECKED_OUT_FOLDER/* .
}

mininix_step_host_build () {
	mininix_setup_cmake
	local protoinstall=$MININIX_TOPDIR/libprotobuf/host-build/install
	cd $MININIX_PKG_SRCDIR
	export LD=gcc
	export LDXX=g++
	CFLAGS="-Wno-implicit-fallthrough" \
		make -j $MININIX_MAKE_PROCESSES \
		HAS_SYSTEM_PROTOBUF=false \
		prefix=$MININIX_PKG_HOSTBUILD_DIR \
		install
	make clean
}

mininix_step_pre_configure() {
	sed "s|@PATH_TO_PLUGIN@|$MININIX_PKG_HOSTBUILD_DIR/bin/grpc_cpp_plugin|g" \
		$MININIX_PKG_BUILDER_DIR/CMakeLists.txt.diff \
		| patch -p1
	export GRPC_CROSS_COMPILE=true
}
