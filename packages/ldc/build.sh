MININIX_PKG_HOMEPAGE=https://github.com/ldc-developers/ldc
MININIX_PKG_DESCRIPTION="D programming language compiler, built with LLVM"
MININIX_PKG_VERSION=()
MININIX_PKG_VERSION+=(1.12.0)
MININIX_PKG_VERSION+=(7.0.0)   # LLVM version
MININIX_PKG_VERSION+=(2.082.1) # TOOLS version
MININIX_PKG_VERSION+=(1.11.0)  # DUB version

MININIX_PKG_SRCURL=(https://github.com/ldc-developers/ldc/releases/download/v${MININIX_PKG_VERSION}/ldc-${MININIX_PKG_VERSION}-src.tar.gz
		   https://github.com/ldc-developers/llvm/releases/download/ldc-v${MININIX_PKG_VERSION[1]}/llvm-${MININIX_PKG_VERSION[1]}.src.tar.xz
		   https://github.com/dlang/tools/archive/v${MININIX_PKG_VERSION[2]}.tar.gz
		   https://github.com/dlang/dub/archive/v${MININIX_PKG_VERSION[3]}.tar.gz
		   https://github.com/ldc-developers/ldc/releases/download/v${MININIX_PKG_VERSION}/ldc2-${MININIX_PKG_VERSION}-linux-x86_64.tar.xz)
MININIX_PKG_SHA256=(952ba57a957079345333d3f6aaaac766cc49750859357c419efc0c897850b5b9
		   cc4f6fd2ec9002a9c7f4ff731c81be5b50672dd6d359e901ce58030f82f7b38a
		   19c02fba1cb270cda3d7101448f36974e623e09a696ce2310a742faf2f3dfdad
		   ef3f7d6ce0b726530973d9348a94fd91f9d02d30851ef3257ff538af4af571b6
		   eeb83d3356d6ba3f5892f629de466df79c02bac5fd1f0e1ecdf01fe6171d42ac)
MININIX_PKG_DEPENDS="clang"
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_BLACKLISTED_ARCHES="x86_64"
MININIX_PKG_FORCE_CMAKE=yes
#These CMake args are only used to configure a patched LLVM
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
-DLLVM_ENABLE_PIC=ON
-DLLVM_BUILD_TOOLS=OFF
-DLLVM_BUILD_UTILS=OFF
-DLLVM_TABLEGEN=$MININIX_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DPYTHON_EXECUTABLE=`which python3`
"
MININIX_PKG_KEEP_STATIC_LIBRARIES=true
MININIX_PKG_NO_DEVELSPLIT=yes
MININIX_PKG_MAINTAINER="Joakim @joakim-noah"

mininix_step_post_extract_package () {
	mv llvm-${MININIX_PKG_VERSION[1]}.src llvm
	mv tools-${MININIX_PKG_VERSION[2]} rdmd
	mv dub-${MININIX_PKG_VERSION[3]} dub

	export LLVM_TRIPLE=${MININIX_HOST_PLATFORM/-/--}
	if [ $MININIX_ARCH = arm ]; then LLVM_TRIPLE=${LLVM_TRIPLE/arm-/armv7a-}; fi
	sed $MININIX_PKG_BUILDER_DIR/llvm-config.in \
		-e "s|@LLVM_VERSION@|${MININIX_PKG_VERSION[1]}|g" \
		-e "s|@LLVM_BUILD_DIR@|$MININIX_PKG_BUILDDIR/llvm|g" \
		-e "s|@MININIX_PKG_SRCDIR@|$MININIX_PKG_SRCDIR|g" \
		-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_TRIPLE|g" \
		-e "s|@LLVM_TARGETS@|ARM AArch64 X86|g" > $MININIX_PKG_BUILDDIR/llvm-config
	chmod 755 $MININIX_PKG_BUILDDIR/llvm-config
}

mininix_step_host_build () {
	mininix_setup_cmake
	mininix_setup_ninja
	cmake -GNinja $MININIX_PKG_SRCDIR/llvm \
		-DLLVM_BUILD_TOOLS=OFF \
		-DLLVM_BUILD_UTILS=OFF \
		-DCOMPILER_RT_INCLUDE_TESTS=OFF
	ninja -j $MININIX_MAKE_PROCESSES llvm-tblgen
}

mininix_step_pre_configure () {
	local LLVM_TARGET_ARCH
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
	MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_DEFAULT_TARGET_TRIPLE=${LLVM_TRIPLE}"
	MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=${LLVM_TARGET_ARCH} -DLLVM_TARGETS_TO_BUILD=AArch64;ARM;X86"

	# CPPFLAGS adds the system llvm to the include path, which causes
	# conflicts with the local patched llvm when compiling ldc
	CPPFLAGS=""

	OLD_MININIX_PKG_SRCDIR=$MININIX_PKG_SRCDIR
	MININIX_PKG_SRCDIR=$MININIX_PKG_SRCDIR/llvm

	OLD_MININIX_PKG_BUILDDIR=$MININIX_PKG_BUILDDIR
	MININIX_PKG_BUILDDIR=$MININIX_PKG_BUILDDIR/llvm
	mkdir "$MININIX_PKG_BUILDDIR"
}

mininix_step_post_configure () {
	MININIX_PKG_SRCDIR=$OLD_MININIX_PKG_SRCDIR
	MININIX_PKG_BUILDDIR=$OLD_MININIX_PKG_BUILDDIR
	cd "$MININIX_PKG_BUILDDIR"

	mv llvm-config llvm/bin

	export LDC_FLAGS="-mtriple=$LLVM_TRIPLE"
	if [ $MININIX_ARCH = arm ]; then LDC_FLAGS="$LDC_FLAGS;-mcpu=cortex-a8"; fi

	export LDC_PATH=$MININIX_PKG_SRCDIR/ldc2-$MININIX_PKG_VERSION-linux-x86_64

	# Couldn't use -DD_COMPILER_FLAGS_ENV_INIT=\"${LDC_FLAGS//;/ }\"" because of the space
	MININIX_PKG_EXTRA_CONFIGURE_ARGS=" -DD_FLAGS=$LDC_FLAGS \
		-DLLVM_CONFIG=$MININIX_PKG_BUILDDIR/llvm/bin/llvm-config \
		-DD_COMPILER=$LDC_PATH/bin/ldmd2"

	mininix_step_configure_cmake
}

mininix_step_make () {
	$LDC_PATH/bin/ldc-build-runtime --ninja -j $MININIX_MAKE_PROCESSES \
		--dFlags="$LDC_FLAGS" --cFlags="$CFLAGS -I$MININIX_PREFIX/include" \
		--targetSystem="Android;Linux;UNIX" --ldcSrcDir="$MININIX_PKG_SRCDIR"

	cd llvm
	if test -f build.ninja; then
		ninja -j $MININIX_MAKE_PROCESSES
	fi

	cd ..
	export DFLAGS="${LDC_FLAGS//;/ }"

	if test -f build.ninja; then
		ninja -j $MININIX_MAKE_PROCESSES ldc2 ldmd2 ldc-build-runtime
	fi

	# Build the rdmd scripting wrapper and the dub package manager
	DMD=$LDC_PATH/bin/ldmd2
	D_FLAGS="-w -de -O"
	D_LDFLAGS="-fuse-ld=bfd -L$MININIX_PKG_BUILDDIR/ldc-build-runtime.tmp/lib -lphobos2-ldc -ldruntime-ldc -Wl,--gc-sections -ldl -lm -fPIE -pie -Wl,-z,nocopyreloc ${LDFLAGS}"
	if [ $MININIX_ARCH = arm ]; then D_LDFLAGS="$D_LDFLAGS -Wl,--fix-cortex-a8"; fi

	$DMD $D_FLAGS -c $MININIX_PKG_SRCDIR/rdmd/rdmd.d -of=$MININIX_PKG_BUILDDIR/bin/rdmd.o
	$CC $MININIX_PKG_BUILDDIR/bin/rdmd.o $D_LDFLAGS -o $MININIX_PKG_BUILDDIR/bin/rdmd

	cd $MININIX_PKG_SRCDIR/dub
	$DMD $D_FLAGS -version=DubUseCurl -Isource -c @build-files.txt -of=$MININIX_PKG_BUILDDIR/bin/dub.o
	$CC $MININIX_PKG_BUILDDIR/bin/dub.o $D_LDFLAGS -o $MININIX_PKG_BUILDDIR/bin/dub
}

mininix_step_make_install () {
	cp bin/{dub,ldc-build-runtime,ldc2,ldmd2,rdmd} $MININIX_PREFIX/bin
	cp $MININIX_PKG_BUILDDIR/ldc-build-runtime.tmp/lib/lib{druntime,phobos2}*.a $MININIX_PREFIX/lib
	sed -i "/runtime\/druntime\/src/d" bin/ldc2.conf
	sed -i "/runtime\/jit-rt\/d/d" bin/ldc2.conf
	sed -i "s|$MININIX_PKG_SRCDIR/runtime/phobos|%%ldcbinarypath%%/../include/d|" bin/ldc2.conf
	sed "s|$MININIX_PKG_BUILDDIR/lib|%%ldcbinarypath%%/../lib|" bin/ldc2.conf > $MININIX_PREFIX/etc/ldc2.conf

	rm -Rf $MININIX_PREFIX/include/d
	mkdir $MININIX_PREFIX/include/d
	cp -r $MININIX_PKG_SRCDIR/runtime/druntime/src/{core,etc,ldc,object.d} $MININIX_PREFIX/include/d
	cp $LDC_PATH/import/ldc/gccbuiltins_{aarch64,arm,x86}.di $MININIX_PREFIX/include/d/ldc
	cp -r $MININIX_PKG_SRCDIR/runtime/phobos/etc/c $MININIX_PREFIX/include/d/etc
	rm -Rf $MININIX_PREFIX/include/d/etc/c/zlib
	cp -r $MININIX_PKG_SRCDIR/runtime/phobos/std $MININIX_PREFIX/include/d

	rm -Rf $MININIX_PREFIX/share/ldc
	mkdir $MININIX_PREFIX/share/ldc
	cp -r $MININIX_PKG_SRCDIR/{LICENSE,README,bash_completion.d} $MININIX_PREFIX/share/ldc
}
