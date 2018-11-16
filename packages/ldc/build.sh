LINUXDROID_PKG_HOMEPAGE=https://github.com/ldc-developers/ldc
LINUXDROID_PKG_DESCRIPTION="D programming language compiler, built with LLVM"
LINUXDROID_PKG_VERSION=()
LINUXDROID_PKG_VERSION+=(1.12.0)
LINUXDROID_PKG_VERSION+=(7.0.0)   # LLVM version
LINUXDROID_PKG_VERSION+=(2.082.1) # TOOLS version
LINUXDROID_PKG_VERSION+=(1.11.0)  # DUB version

LINUXDROID_PKG_SRCURL=(https://github.com/ldc-developers/ldc/releases/download/v${LINUXDROID_PKG_VERSION}/ldc-${LINUXDROID_PKG_VERSION}-src.tar.gz
		   https://github.com/ldc-developers/llvm/releases/download/ldc-v${LINUXDROID_PKG_VERSION[1]}/llvm-${LINUXDROID_PKG_VERSION[1]}.src.tar.xz
		   https://github.com/dlang/tools/archive/v${LINUXDROID_PKG_VERSION[2]}.tar.gz
		   https://github.com/dlang/dub/archive/v${LINUXDROID_PKG_VERSION[3]}.tar.gz
		   https://github.com/ldc-developers/ldc/releases/download/v${LINUXDROID_PKG_VERSION}/ldc2-${LINUXDROID_PKG_VERSION}-linux-x86_64.tar.xz)
LINUXDROID_PKG_SHA256=(952ba57a957079345333d3f6aaaac766cc49750859357c419efc0c897850b5b9
		   cc4f6fd2ec9002a9c7f4ff731c81be5b50672dd6d359e901ce58030f82f7b38a
		   19c02fba1cb270cda3d7101448f36974e623e09a696ce2310a742faf2f3dfdad
		   ef3f7d6ce0b726530973d9348a94fd91f9d02d30851ef3257ff538af4af571b6
		   eeb83d3356d6ba3f5892f629de466df79c02bac5fd1f0e1ecdf01fe6171d42ac)
LINUXDROID_PKG_DEPENDS="clang"
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_BLACKLISTED_ARCHES="x86_64"
LINUXDROID_PKG_FORCE_CMAKE=yes
#These CMake args are only used to configure a patched LLVM
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DLLVM_ENABLE_PIC=ON
-DLLVM_BUILD_TOOLS=OFF
-DLLVM_BUILD_UTILS=OFF
-DLLVM_TABLEGEN=$LINUXDROID_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DPYTHON_EXECUTABLE=`which python3`
"
LINUXDROID_PKG_KEEP_STATIC_LIBRARIES=true
LINUXDROID_PKG_NO_DEVELSPLIT=yes
LINUXDROID_PKG_MAINTAINER="Joakim @joakim-noah"

linuxdroid_step_post_extract_package () {
	mv llvm-${LINUXDROID_PKG_VERSION[1]}.src llvm
	mv tools-${LINUXDROID_PKG_VERSION[2]} rdmd
	mv dub-${LINUXDROID_PKG_VERSION[3]} dub

	export LLVM_TRIPLE=${LINUXDROID_HOST_PLATFORM/-/--}
	if [ $LINUXDROID_ARCH = arm ]; then LLVM_TRIPLE=${LLVM_TRIPLE/arm-/armv7a-}; fi
	sed $LINUXDROID_PKG_BUILDER_DIR/llvm-config.in \
		-e "s|@LLVM_VERSION@|${LINUXDROID_PKG_VERSION[1]}|g" \
		-e "s|@LLVM_BUILD_DIR@|$LINUXDROID_PKG_BUILDDIR/llvm|g" \
		-e "s|@LINUXDROID_PKG_SRCDIR@|$LINUXDROID_PKG_SRCDIR|g" \
		-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_TRIPLE|g" \
		-e "s|@LLVM_TARGETS@|ARM AArch64 X86|g" > $LINUXDROID_PKG_BUILDDIR/llvm-config
	chmod 755 $LINUXDROID_PKG_BUILDDIR/llvm-config
}

linuxdroid_step_host_build () {
	linuxdroid_setup_cmake
	linuxdroid_setup_ninja
	cmake -GNinja $LINUXDROID_PKG_SRCDIR/llvm \
		-DLLVM_BUILD_TOOLS=OFF \
		-DLLVM_BUILD_UTILS=OFF \
		-DCOMPILER_RT_INCLUDE_TESTS=OFF
	ninja -j $LINUXDROID_MAKE_PROCESSES llvm-tblgen
}

linuxdroid_step_pre_configure () {
	local LLVM_TARGET_ARCH
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
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_DEFAULT_TARGET_TRIPLE=${LLVM_TRIPLE}"
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=${LLVM_TARGET_ARCH} -DLLVM_TARGETS_TO_BUILD=AArch64;ARM;X86"

	# CPPFLAGS adds the system llvm to the include path, which causes
	# conflicts with the local patched llvm when compiling ldc
	CPPFLAGS=""

	OLD_LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_SRCDIR
	LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_SRCDIR/llvm

	OLD_LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_BUILDDIR
	LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_BUILDDIR/llvm
	mkdir "$LINUXDROID_PKG_BUILDDIR"
}

linuxdroid_step_post_configure () {
	LINUXDROID_PKG_SRCDIR=$OLD_LINUXDROID_PKG_SRCDIR
	LINUXDROID_PKG_BUILDDIR=$OLD_LINUXDROID_PKG_BUILDDIR
	cd "$LINUXDROID_PKG_BUILDDIR"

	mv llvm-config llvm/bin

	export LDC_FLAGS="-mtriple=$LLVM_TRIPLE"
	if [ $LINUXDROID_ARCH = arm ]; then LDC_FLAGS="$LDC_FLAGS;-mcpu=cortex-a8"; fi

	export LDC_PATH=$LINUXDROID_PKG_SRCDIR/ldc2-$LINUXDROID_PKG_VERSION-linux-x86_64

	# Couldn't use -DD_COMPILER_FLAGS_ENV_INIT=\"${LDC_FLAGS//;/ }\"" because of the space
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS=" -DD_FLAGS=$LDC_FLAGS \
		-DLLVM_CONFIG=$LINUXDROID_PKG_BUILDDIR/llvm/bin/llvm-config \
		-DD_COMPILER=$LDC_PATH/bin/ldmd2"

	linuxdroid_step_configure_cmake
}

linuxdroid_step_make () {
	$LDC_PATH/bin/ldc-build-runtime --ninja -j $LINUXDROID_MAKE_PROCESSES \
		--dFlags="$LDC_FLAGS" --cFlags="$CFLAGS -I$LINUXDROID_PREFIX/include" \
		--targetSystem="Android;Linux;UNIX" --ldcSrcDir="$LINUXDROID_PKG_SRCDIR"

	cd llvm
	if test -f build.ninja; then
		ninja -j $LINUXDROID_MAKE_PROCESSES
	fi

	cd ..
	export DFLAGS="${LDC_FLAGS//;/ }"

	if test -f build.ninja; then
		ninja -j $LINUXDROID_MAKE_PROCESSES ldc2 ldmd2 ldc-build-runtime
	fi

	# Build the rdmd scripting wrapper and the dub package manager
	DMD=$LDC_PATH/bin/ldmd2
	D_FLAGS="-w -de -O"
	D_LDFLAGS="-fuse-ld=bfd -L$LINUXDROID_PKG_BUILDDIR/ldc-build-runtime.tmp/lib -lphobos2-ldc -ldruntime-ldc -Wl,--gc-sections -ldl -lm -fPIE -pie -Wl,-z,nocopyreloc ${LDFLAGS}"
	if [ $LINUXDROID_ARCH = arm ]; then D_LDFLAGS="$D_LDFLAGS -Wl,--fix-cortex-a8"; fi

	$DMD $D_FLAGS -c $LINUXDROID_PKG_SRCDIR/rdmd/rdmd.d -of=$LINUXDROID_PKG_BUILDDIR/bin/rdmd.o
	$CC $LINUXDROID_PKG_BUILDDIR/bin/rdmd.o $D_LDFLAGS -o $LINUXDROID_PKG_BUILDDIR/bin/rdmd

	cd $LINUXDROID_PKG_SRCDIR/dub
	$DMD $D_FLAGS -version=DubUseCurl -Isource -c @build-files.txt -of=$LINUXDROID_PKG_BUILDDIR/bin/dub.o
	$CC $LINUXDROID_PKG_BUILDDIR/bin/dub.o $D_LDFLAGS -o $LINUXDROID_PKG_BUILDDIR/bin/dub
}

linuxdroid_step_make_install () {
	cp bin/{dub,ldc-build-runtime,ldc2,ldmd2,rdmd} $LINUXDROID_PREFIX/bin
	cp $LINUXDROID_PKG_BUILDDIR/ldc-build-runtime.tmp/lib/lib{druntime,phobos2}*.a $LINUXDROID_PREFIX/lib
	sed -i "/runtime\/druntime\/src/d" bin/ldc2.conf
	sed -i "/runtime\/jit-rt\/d/d" bin/ldc2.conf
	sed -i "s|$LINUXDROID_PKG_SRCDIR/runtime/phobos|%%ldcbinarypath%%/../include/d|" bin/ldc2.conf
	sed "s|$LINUXDROID_PKG_BUILDDIR/lib|%%ldcbinarypath%%/../lib|" bin/ldc2.conf > $LINUXDROID_PREFIX/etc/ldc2.conf

	rm -Rf $LINUXDROID_PREFIX/include/d
	mkdir $LINUXDROID_PREFIX/include/d
	cp -r $LINUXDROID_PKG_SRCDIR/runtime/druntime/src/{core,etc,ldc,object.d} $LINUXDROID_PREFIX/include/d
	cp $LDC_PATH/import/ldc/gccbuiltins_{aarch64,arm,x86}.di $LINUXDROID_PREFIX/include/d/ldc
	cp -r $LINUXDROID_PKG_SRCDIR/runtime/phobos/etc/c $LINUXDROID_PREFIX/include/d/etc
	rm -Rf $LINUXDROID_PREFIX/include/d/etc/c/zlib
	cp -r $LINUXDROID_PKG_SRCDIR/runtime/phobos/std $LINUXDROID_PREFIX/include/d

	rm -Rf $LINUXDROID_PREFIX/share/ldc
	mkdir $LINUXDROID_PREFIX/share/ldc
	cp -r $LINUXDROID_PKG_SRCDIR/{LICENSE,README,bash_completion.d} $LINUXDROID_PREFIX/share/ldc
}
