LINUXDROID_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
LINUXDROID_PKG_DESCRIPTION="System header and library files from the Android NDK needed for compiling C programs"
LINUXDROID_PKG_VERSION=$LINUXDROID_NDK_VERSION
LINUXDROID_PKG_REVISION=8
LINUXDROID_PKG_NO_DEVELSPLIT=yes
# Depend on libandroid-support-dev so that iconv.h and libintl.h are available:
LINUXDROID_PKG_DEPENDS="libandroid-support-dev"
LINUXDROID_PKG_KEEP_STATIC_LIBRARIES="true"
# This package has taken over <pty.h> from the previous libutil-dev:
LINUXDROID_PKG_CONFLICTS="libutil-dev, libgcc"
LINUXDROID_PKG_REPLACES="libutil-dev, libgcc"

linuxdroid_step_extract_into_massagedir () {
	mkdir -p $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/lib/pkgconfig \
		$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/include

	cp -Rf $LINUXDROID_STANDALONE_TOOLCHAIN/sysroot/usr/include/* \
		$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/include

	local _LIBDIR=lib
	if [ "$LINUXDROID_ARCH" = "x86_64" ]; then
		_LIBDIR=lib64
	fi
	cp $LINUXDROID_STANDALONE_TOOLCHAIN/sysroot/usr/${_LIBDIR}/*.o \
		$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/lib

	cp "$PKG_CONFIG_LIBDIR/zlib.pc" \
		$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/lib/pkgconfig/zlib.pc

	local LIBATOMIC_PATH=$LINUXDROID_STANDALONE_TOOLCHAIN/$LINUXDROID_HOST_PLATFORM/lib
	if [ $LINUXDROID_ARCH_BITS = 64 ]; then LIBATOMIC_PATH+="64"; fi
	if [ $LINUXDROID_ARCH = "arm" ]; then LIBATOMIC_PATH+="/armv7-a"; fi
	LIBATOMIC_PATH+="/libatomic.a"
	cp $LIBATOMIC_PATH $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/lib/

	local LIBGCC_PATH=$LINUXDROID_STANDALONE_TOOLCHAIN/lib/gcc/$LINUXDROID_HOST_PLATFORM/4.9.x
	if [ $LINUXDROID_ARCH = "arm" ]; then LIBGCC_PATH+="/armv7-a"; fi
	LIBGCC_PATH+="/libgcc.a"
	cp $LIBGCC_PATH $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/lib/

	# librt and libpthread are built into libc on android, so setup them as symlinks
	# to libc for compatibility with programs that users try to build:
	local _SYSTEM_LIBDIR=/system/lib64
	if [ $LINUXDROID_ARCH_BITS = 32 ]; then _SYSTEM_LIBDIR=/system/lib; fi
	mkdir -p $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/lib
	cd $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/lib
	ln -f -s $_SYSTEM_LIBDIR/libc.so librt.so
	ln -f -s $_SYSTEM_LIBDIR/libc.so libpthread.so
}
