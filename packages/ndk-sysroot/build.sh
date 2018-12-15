MININIX_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
MININIX_PKG_DESCRIPTION="System header and library files from the Android NDK needed for compiling C programs"
MININIX_PKG_VERSION=$MININIX_NDK_VERSION
MININIX_PKG_REVISION=8
MININIX_PKG_NO_DEVELSPLIT=yes
# Depend on libandroid-support-dev so that iconv.h and libintl.h are available:
MININIX_PKG_DEPENDS="libandroid-support-dev"
MININIX_PKG_KEEP_STATIC_LIBRARIES="true"
# This package has taken over <pty.h> from the previous libutil-dev:
MININIX_PKG_CONFLICTS="libutil-dev, libgcc"
MININIX_PKG_REPLACES="libutil-dev, libgcc"

mininix_step_extract_into_massagedir () {
	mkdir -p $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib/pkgconfig \
		$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/include

	cp -Rf $MININIX_STANDALONE_TOOLCHAIN/sysroot/usr/include/* \
		$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/include

	local _LIBDIR=lib
	if [ "$MININIX_ARCH" = "x86_64" ]; then
		_LIBDIR=lib64
	fi
	cp $MININIX_STANDALONE_TOOLCHAIN/sysroot/usr/${_LIBDIR}/*.o \
		$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib

	cp "$PKG_CONFIG_LIBDIR/zlib.pc" \
		$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib/pkgconfig/zlib.pc

	local LIBATOMIC_PATH=$MININIX_STANDALONE_TOOLCHAIN/$MININIX_HOST_PLATFORM/lib
	if [ $MININIX_ARCH_BITS = 64 ]; then LIBATOMIC_PATH+="64"; fi
	if [ $MININIX_ARCH = "arm" ]; then LIBATOMIC_PATH+="/armv7-a"; fi
	LIBATOMIC_PATH+="/libatomic.a"
	cp $LIBATOMIC_PATH $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib/

	local LIBGCC_PATH=$MININIX_STANDALONE_TOOLCHAIN/lib/gcc/$MININIX_HOST_PLATFORM/4.9.x
	if [ $MININIX_ARCH = "arm" ]; then LIBGCC_PATH+="/armv7-a"; fi
	LIBGCC_PATH+="/libgcc.a"
	cp $LIBGCC_PATH $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib/

	# librt and libpthread are built into libc on android, so setup them as symlinks
	# to libc for compatibility with programs that users try to build:
	local _SYSTEM_LIBDIR=/system/lib64
	if [ $MININIX_ARCH_BITS = 32 ]; then _SYSTEM_LIBDIR=/system/lib; fi
	mkdir -p $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib
	cd $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib
	ln -f -s $_SYSTEM_LIBDIR/libc.so librt.so
	ln -f -s $_SYSTEM_LIBDIR/libc.so libpthread.so
}
