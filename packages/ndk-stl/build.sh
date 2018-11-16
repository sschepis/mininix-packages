LINUXDROID_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
LINUXDROID_PKG_DESCRIPTION="Header files from the Android NDK needed for compiling C++ programs using STL"
LINUXDROID_PKG_VERSION=$LINUXDROID_NDK_VERSION
LINUXDROID_PKG_REVISION=4
LINUXDROID_PKG_NO_DEVELSPLIT=yes

linuxdroid_step_extract_into_massagedir () {
	mkdir -p $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/include/c++/v1/
	cp -Rf $LINUXDROID_STANDALONE_TOOLCHAIN/include/c++/4.9.x/* $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/include/c++/v1/

	( cd  $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/include/c++/v1/ && patch -p1 < $LINUXDROID_PKG_BUILDER_DIR/math-header.diff )

	# Revert the patch for <cstddef> that's only used for using g++
	# from the ndk (https://github.com/android-ndk/ndk/issues/215):
	cd $LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/include/c++/v1/
	sed "s%\@LINUXDROID_HOST_PLATFORM\@%${LINUXDROID_HOST_PLATFORM}%g" $LINUXDROID_SCRIPTDIR/ndk-patches/cstddef.cpppatch | patch -p1 -R
}

linuxdroid_step_massage () {
	echo "overriding linuxdroid_step_massage to avoid removing header files"
}
