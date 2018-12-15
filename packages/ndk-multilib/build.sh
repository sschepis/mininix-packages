MININIX_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
MININIX_PKG_DESCRIPTION="Multilib binaries for cross-compilation"
MININIX_PKG_VERSION=$MININIX_NDK_VERSION
MININIX_PKG_REVISION=3
MININIX_PKG_NO_DEVELSPLIT=yes
MININIX_PKG_KEEP_STATIC_LIBRARIES="true"
MININIX_PKG_PLATFORM_INDEPENDENT=true

prepare_libs () {
	local ARCH="$1"
	local SUFFIX="$2"
	local NDK_SUFFIX=$SUFFIX

	if [ $ARCH = x86 ] || [ $ARCH = x86_64 ]; then
	    NDK_SUFFIX=$ARCH
	fi

	mkdir -p $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/$SUFFIX/lib
	local BASEDIR=$NDK/platforms/android-${MININIX_PKG_API_LEVEL}/arch-$ARCH/usr/lib
	if [ $ARCH = x86_64 ]; then BASEDIR+="64"; fi
	cp $BASEDIR/*.o $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/$SUFFIX/lib

	LIBATOMIC=$NDK/toolchains/${NDK_SUFFIX}-*/prebuilt/linux-*/${SUFFIX}/lib
	if [ $ARCH = "arm64" ] || [ $ARCH = "x86_64" ]; then LIBATOMIC+="64"; fi
	if [ $ARCH = "arm" ]; then LIBATOMIC+="/armv7-a"; fi
	cp $LIBATOMIC/libatomic.a $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/$SUFFIX/lib/

	LIBGCC=$NDK/toolchains/${NDK_SUFFIX}-*/prebuilt/linux-*/lib/gcc/${SUFFIX}/4.9.x
	if [ $ARCH = "arm" ]; then LIBGCC+="/armv7-a"; fi
	cp $LIBGCC/libgcc.a $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/$SUFFIX/lib/
}

mininix_step_extract_into_massagedir () {
	prepare_libs "arm" "arm-linux-androideabi"
	prepare_libs "arm64" "aarch64-linux-android"
	prepare_libs "x86" "i686-linux-android"
	prepare_libs "x86_64" "x86_64-linux-android"
}
