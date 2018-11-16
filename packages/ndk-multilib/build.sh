LINUXDROID_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
LINUXDROID_PKG_DESCRIPTION="Multilib binaries for cross-compilation"
LINUXDROID_PKG_VERSION=$LINUXDROID_NDK_VERSION
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_NO_DEVELSPLIT=yes
LINUXDROID_PKG_KEEP_STATIC_LIBRARIES="true"
LINUXDROID_PKG_PLATFORM_INDEPENDENT=true

prepare_libs () {
	local ARCH="$1"
	local SUFFIX="$2"
	local NDK_SUFFIX=$SUFFIX

	if [ $ARCH = x86 ] || [ $ARCH = x86_64 ]; then
	    NDK_SUFFIX=$ARCH
	fi

	mkdir -p $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/$SUFFIX/lib
	local BASEDIR=$NDK/platforms/android-${LINUXDROID_PKG_API_LEVEL}/arch-$ARCH/usr/lib
	if [ $ARCH = x86_64 ]; then BASEDIR+="64"; fi
	cp $BASEDIR/*.o $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/$SUFFIX/lib

	LIBATOMIC=$NDK/toolchains/${NDK_SUFFIX}-*/prebuilt/linux-*/${SUFFIX}/lib
	if [ $ARCH = "arm64" ] || [ $ARCH = "x86_64" ]; then LIBATOMIC+="64"; fi
	if [ $ARCH = "arm" ]; then LIBATOMIC+="/armv7-a"; fi
	cp $LIBATOMIC/libatomic.a $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/$SUFFIX/lib/

	LIBGCC=$NDK/toolchains/${NDK_SUFFIX}-*/prebuilt/linux-*/lib/gcc/${SUFFIX}/4.9.x
	if [ $ARCH = "arm" ]; then LIBGCC+="/armv7-a"; fi
	cp $LIBGCC/libgcc.a $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/$SUFFIX/lib/
}

linuxdroid_step_extract_into_massagedir () {
	prepare_libs "arm" "arm-linux-androideabi"
	prepare_libs "arm64" "aarch64-linux-android"
	prepare_libs "x86" "i686-linux-android"
	prepare_libs "x86_64" "x86_64-linux-android"
}
