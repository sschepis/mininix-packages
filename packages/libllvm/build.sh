MININIX_PKG_HOMEPAGE=https://clang.llvm.org/
MININIX_PKG_DESCRIPTION="Modular compiler and toolchain technologies library"
MININIX_PKG_VERSION=7.0.0
MININIX_PKG_SHA256=(8bc1f844e6cbde1b652c19c1edebc1864456fd9c78b8c1bea038e51b363fe222
		   550212711c752697d2f82c648714a7221b1207fd9441543ff4aa9e3be45bba55
		   fbcf47c5e543f4cdac6bb9bbbc6327ff24217cd7eafc5571549ad6d237287f9c
		   30662b632f5556c59ee9215c1309f61de50b3ea8e89dcc28ba9a9494bba238ff)
MININIX_PKG_SRCURL=(https://releases.llvm.org/${MININIX_PKG_VERSION}/llvm-${MININIX_PKG_VERSION}.src.tar.xz
		   https://releases.llvm.org/${MININIX_PKG_VERSION}/cfe-${MININIX_PKG_VERSION}.src.tar.xz
		   https://llvm.org/releases/${MININIX_PKG_VERSION}/lld-${MININIX_PKG_VERSION}.src.tar.xz
		   https://releases.llvm.org/${MININIX_PKG_VERSION}/openmp-${MININIX_PKG_VERSION}.src.tar.xz)
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_RM_AFTER_INSTALL="
bin/clang-check
bin/clang-import-test
bin/clang-offload-bundler
bin/git-clang-format
bin/macho-dump
lib/libgomp.a
lib/libiomp5.a
"
MININIX_PKG_DEPENDS="binutils, ncurses, ndk-sysroot, ndk-stl, libffi"
# Replace gcc since gcc is deprecated by google on android and is not maintained upstream.
# Conflict with clang versions earlier than 3.9.1-3 since they bundled llvm.
MININIX_PKG_CONFLICTS="gcc, clang (<< 3.9.1-3)"
MININIX_PKG_REPLACES=gcc
# See http://llvm.org/docs/CMake.html:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
-DPYTHON_EXECUTABLE=`which python3`
-DLLVM_ENABLE_PIC=ON
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_BUILD_TESTS=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DCLANG_DEFAULT_CXX_STDLIB=libc++
-DCLANG_INCLUDE_TESTS=OFF
-DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF
-DC_INCLUDE_DIRS=$MININIX_PREFIX/include
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLVM_TABLEGEN=$MININIX_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DCLANG_TABLEGEN=$MININIX_PKG_HOSTBUILD_DIR/bin/clang-tblgen
-DLIBOMP_ENABLE_SHARED=FALSE
-DOPENMP_ENABLE_LIBOMPTARGET=OFF
-DLLVM_BINUTILS_INCDIR=$MININIX_PREFIX/include
-DLLVM_ENABLE_SPHINX=ON
-DSPHINX_OUTPUT_MAN=ON
-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly
-DPERL_EXECUTABLE=$(which perl)
-DLLVM_ENABLE_FFI=ON
"
MININIX_PKG_FORCE_CMAKE=yes
MININIX_PKG_KEEP_STATIC_LIBRARIES=true
MININIX_PKG_HAS_DEBUG=no

mininix_step_post_extract_package () {
	mv cfe-${MININIX_PKG_VERSION}.src tools/clang
	mv lld-${MININIX_PKG_VERSION}.src tools/lld
	mv openmp-${MININIX_PKG_VERSION}.src projects/openmp
}

mininix_step_host_build () {
	mininix_setup_cmake
	cmake -G "Unix Makefiles" $MININIX_PKG_SRCDIR \
		-DLLVM_BUILD_TESTS=OFF \
		-DLLVM_INCLUDE_TESTS=OFF
	make -j $MININIX_MAKE_PROCESSES clang-tblgen llvm-tblgen
}

mininix_step_pre_configure () {
	mkdir projects/openmp/runtime/src/android
	cp $MININIX_PKG_BUILDER_DIR/nl_types.h projects/openmp/runtime/src/android
	cp $MININIX_PKG_BUILDER_DIR/nltypes_stubs.cpp projects/openmp/runtime/src/android

	cd $MININIX_PKG_BUILDDIR
	export LLVM_DEFAULT_TARGET_TRIPLE=$MININIX_HOST_PLATFORM
	export LLVM_TARGET_ARCH
	if [ $MININIX_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $MININIX_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $MININIX_ARCH = "i686" ]; then
		LLVM_TARGET_ARCH=X86
	elif [ $MININIX_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		mininix_error_exit "Invalid arch: $MININIX_ARCH"
	fi
        # see CMakeLists.txt and tools/clang/CMakeLists.txt
	MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_DEFAULT_TARGET_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
	MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH -DLLVM_TARGETS_TO_BUILD=all"
	MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
}
mininix_step_post_make_install () {
	if [ $MININIX_ARCH = "arm" ]; then
		cp ../src/projects/openmp/runtime/exports/common.min.50/include/omp.h $MININIX_PREFIX/include
	else
		cp ../src/projects/openmp/runtime/exports/common.min.50.ompt.optional/include/omp.h $MININIX_PREFIX/include
	fi

	if [ $MININIX_CMAKE_BUILD = Ninja ]; then
		ninja docs-llvm-man
	else
		make docs-llvm-man
	fi

	cp docs/man/* $MININIX_PREFIX/share/man/man1
	cd $MININIX_PREFIX/bin

	for tool in clang clang++ cc c++ cpp gcc g++ ${MININIX_HOST_PLATFORM}-{clang,clang++,gcc,g++,cpp}; do
		ln -f -s clang-${MININIX_PKG_VERSION:0:1} $tool
	done
}

mininix_step_post_massage () {
	sed $MININIX_PKG_BUILDER_DIR/llvm-config.in \
		-e "s|@MININIX_PKG_VERSION@|$MININIX_PKG_VERSION|g" \
		-e "s|@MININIX_PREFIX@|$MININIX_PREFIX|g" \
		-e "s|@MININIX_PKG_SRCDIR@|$MININIX_PKG_SRCDIR|g" \
		-e "s|@LLVM_TARGET_ARCH@|$LLVM_TARGET_ARCH|g" \
		-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_DEFAULT_TARGET_TRIPLE|g" \
		-e "s|@MININIX_ARCH@|$MININIX_ARCH|g" > $MININIX_PREFIX/bin/llvm-config
	chmod 755 $MININIX_PREFIX/bin/llvm-config
}
