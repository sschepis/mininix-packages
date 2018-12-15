MININIX_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
MININIX_PKG_DESCRIPTION="Header files from the Android NDK needed for compiling C++ programs using STL"
MININIX_PKG_VERSION=$MININIX_NDK_VERSION
MININIX_PKG_REVISION=4
MININIX_PKG_NO_DEVELSPLIT=yes

mininix_step_extract_into_massagedir () {
	mkdir -p $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/include/c++/v1/
	cp -Rf $MININIX_STANDALONE_TOOLCHAIN/include/c++/4.9.x/* $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/include/c++/v1/

	( cd  $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/include/c++/v1/ && patch -p1 < $MININIX_PKG_BUILDER_DIR/math-header.diff )

	# Revert the patch for <cstddef> that's only used for using g++
	# from the ndk (https://github.com/android-ndk/ndk/issues/215):
	cd $MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/include/c++/v1/
	sed "s%\@MININIX_HOST_PLATFORM\@%${MININIX_HOST_PLATFORM}%g" $MININIX_SCRIPTDIR/ndk-patches/cstddef.cpppatch | patch -p1 -R
}

mininix_step_massage () {
	echo "overriding mininix_step_massage to avoid removing header files"
}
