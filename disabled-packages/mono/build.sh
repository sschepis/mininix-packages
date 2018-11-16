LINUXDROID_PKG_HOMEPAGE=http://www.mono-project.com/
LINUXDROID_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'
_MONO_VERSION=5.0.0
_MONO_PATCH=100
LINUXDROID_PKG_VERSION=$_MONO_VERSION.$_MONO_PATCH
# official package is missing support/libm/math_private.h
#LINUXDROID_PKG_SRCURL=https://github.com/mono/mono/archive/mono-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_SRCURL=https://download.mono-project.com/sources/mono/mono-$LINUXDROID_PKG_VERSION.tar.bz2
LINUXDROID_PKG_SHA256=368da3ff9f42592920cd8cf6fa15c6c16558e967144c4d3df873352e5d2bb6df
LINUXDROID_PKG_FOLDERNAME=mono-$_MONO_VERSION
#LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS='--disable-mcs-build --disable-boehm --with-sigaltstack=no'
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+="--disable-btls --disable-dynamic-btls" #--with-btls-android-ndk=$ANDROID_NDK"
LINUXDROID_PKG_BUILD_IN_SRC=true

linuxdroid_step_pre_configure () {
#	export CFLAGS="$CFLAGS -mthumb"
	cd "$LINUXDROID_PKG_SRCDIR"
#	NOCONFIGURE=1 ./autogen.sh
#	cp $LINUXDROID_PKG_BUILDER_DIR/{complex,math_private}.h $LINUXDROID_PKG_SRCDIR/support/libm/
	export ANDROID_STANDALONE_TOOLCHAIN=$LINUXDROID_STANDALONE_TOOLCHAIN
}

