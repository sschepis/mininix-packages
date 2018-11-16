LINUXDROID_PKG_HOMEPAGE=https://clang.llvm.org/
LINUXDROID_PKG_DESCRIPTION="Modular compiler and toolchain technologies library"
LINUXDROID_PKG_VERSION=7.0.0
LINUXDROID_PKG_SHA256=(8bc1f844e6cbde1b652c19c1edebc1864456fd9c78b8c1bea038e51b363fe222
		   550212711c752697d2f82c648714a7221b1207fd9441543ff4aa9e3be45bba55
		   fbcf47c5e543f4cdac6bb9bbbc6327ff24217cd7eafc5571549ad6d237287f9c
		   30662b632f5556c59ee9215c1309f61de50b3ea8e89dcc28ba9a9494bba238ff)
LINUXDROID_PKG_SRCURL=(https://releases.llvm.org/${LINUXDROID_PKG_VERSION}/llvm-${LINUXDROID_PKG_VERSION}.src.tar.xz
		   https://releases.llvm.org/${LINUXDROID_PKG_VERSION}/cfe-${LINUXDROID_PKG_VERSION}.src.tar.xz
		   https://llvm.org/releases/${LINUXDROID_PKG_VERSION}/lld-${LINUXDROID_PKG_VERSION}.src.tar.xz
		   https://releases.llvm.org/${LINUXDROID_PKG_VERSION}/openmp-${LINUXDROID_PKG_VERSION}.src.tar.xz)
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_RM_AFTER_INSTALL="
bin/clang-check
bin/clang-import-test
bin/clang-offload-bundler
bin/git-clang-format
bin/macho-dump
lib/libgomp.a
lib/libiomp5.a
"
LINUXDROID_PKG_DEPENDS="binutils, ncurses, ndk-sysroot, ndk-stl, libffi"
# Replace gcc since gcc is deprecated by google on android and is not maintained upstream.
# Conflict with clang versions earlier than 3.9.1-3 since they bundled llvm.
LINUXDROID_PKG_CONFLICTS="gcc, clang (<< 3.9.1-3)"
LINUXDROID_PKG_REPLACES=gcc
# See http://llvm.org/docs/CMake.html:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DPYTHON_EXECUTABLE=`which python3`
-DLLVM_ENABLE_PIC=ON
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_BUILD_TESTS=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DCLANG_DEFAULT_CXX_STDLIB=libc++
-DCLANG_INCLUDE_TESTS=OFF
-DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF
-DC_INCLUDE_DIRS=$LINUXDROID_PREFIX/include
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLVM_TABLEGEN=$LINUXDROID_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DCLANG_TABLEGEN=$LINUXDROID_PKG_HOSTBUILD_DIR/bin/clang-tblgen
-DLIBOMP_ENABLE_SHARED=FALSE
-DOPENMP_ENABLE_LIBOMPTARGET=OFF
-DLLVM_BINUTILS_INCDIR=$LINUXDROID_PREFIX/include
-DLLVM_ENABLE_SPHINX=ON
-DSPHINX_OUTPUT_MAN=ON
-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly
-DPERL_EXECUTABLE=$(which perl)
-DLLVM_ENABLE_FFI=ON
"
LINUXDROID_PKG_FORCE_CMAKE=yes
LINUXDROID_PKG_KEEP_STATIC_LIBRARIES=true
LINUXDROID_PKG_HAS_DEBUG=no

linuxdroid_step_post_extract_package () {
	mv cfe-${LINUXDROID_PKG_VERSION}.src tools/clang
	mv lld-${LINUXDROID_PKG_VERSION}.src tools/lld
	mv openmp-${LINUXDROID_PKG_VERSION}.src projects/openmp
}

linuxdroid_step_host_build () {
	linuxdroid_setup_cmake
	cmake -G "Unix Makefiles" $LINUXDROID_PKG_SRCDIR \
		-DLLVM_BUILD_TESTS=OFF \
		-DLLVM_INCLUDE_TESTS=OFF
	make -j $LINUXDROID_MAKE_PROCESSES clang-tblgen llvm-tblgen
}

linuxdroid_step_pre_configure () {
	mkdir projects/openmp/runtime/src/android
	cp $LINUXDROID_PKG_BUILDER_DIR/nl_types.h projects/openmp/runtime/src/android
	cp $LINUXDROID_PKG_BUILDER_DIR/nltypes_stubs.cpp projects/openmp/runtime/src/android

	cd $LINUXDROID_PKG_BUILDDIR
	export LLVM_DEFAULT_TARGET_TRIPLE=$LINUXDROID_HOST_PLATFORM
	export LLVM_TARGET_ARCH
	if [ $LINUXDROID_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $LINUXDROID_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $LINUXDROID_ARCH = "i686" ]; then
		LLVM_TARGET_ARCH=X86
	elif [ $LINUXDROID_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		linuxdroid_error_exit "Invalid arch: $LINUXDROID_ARCH"
	fi
        # see CMakeLists.txt and tools/clang/CMakeLists.txt
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_DEFAULT_TARGET_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH -DLLVM_TARGETS_TO_BUILD=all"
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
}
linuxdroid_step_post_make_install () {
	if [ $LINUXDROID_ARCH = "arm" ]; then
		cp ../src/projects/openmp/runtime/exports/common.min.50/include/omp.h $LINUXDROID_PREFIX/include
	else
		cp ../src/projects/openmp/runtime/exports/common.min.50.ompt.optional/include/omp.h $LINUXDROID_PREFIX/include
	fi

	if [ $LINUXDROID_CMAKE_BUILD = Ninja ]; then
		ninja docs-llvm-man
	else
		make docs-llvm-man
	fi

	cp docs/man/* $LINUXDROID_PREFIX/share/man/man1
	cd $LINUXDROID_PREFIX/bin

	for tool in clang clang++ cc c++ cpp gcc g++ ${LINUXDROID_HOST_PLATFORM}-{clang,clang++,gcc,g++,cpp}; do
		ln -f -s clang-${LINUXDROID_PKG_VERSION:0:1} $tool
	done
}

linuxdroid_step_post_massage () {
	sed $LINUXDROID_PKG_BUILDER_DIR/llvm-config.in \
		-e "s|@LINUXDROID_PKG_VERSION@|$LINUXDROID_PKG_VERSION|g" \
		-e "s|@LINUXDROID_PREFIX@|$LINUXDROID_PREFIX|g" \
		-e "s|@LINUXDROID_PKG_SRCDIR@|$LINUXDROID_PKG_SRCDIR|g" \
		-e "s|@LLVM_TARGET_ARCH@|$LLVM_TARGET_ARCH|g" \
		-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_DEFAULT_TARGET_TRIPLE|g" \
		-e "s|@LINUXDROID_ARCH@|$LINUXDROID_ARCH|g" > $LINUXDROID_PREFIX/bin/llvm-config
	chmod 755 $LINUXDROID_PREFIX/bin/llvm-config
}
