MININIX_PKG_HOMEPAGE=http://www.mono-project.com/
MININIX_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'
_MONO_VERSION=5.0.0
_MONO_PATCH=100
MININIX_PKG_VERSION=$_MONO_VERSION.$_MONO_PATCH
# official package is missing support/libm/math_private.h
#MININIX_PKG_SRCURL=https://github.com/mono/mono/archive/mono-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SRCURL=https://download.mono-project.com/sources/mono/mono-$MININIX_PKG_VERSION.tar.bz2
MININIX_PKG_SHA256=368da3ff9f42592920cd8cf6fa15c6c16558e967144c4d3df873352e5d2bb6df
MININIX_PKG_FOLDERNAME=mono-$_MONO_VERSION
#MININIX_PKG_EXTRA_CONFIGURE_ARGS='--disable-mcs-build --disable-boehm --with-sigaltstack=no'
MININIX_PKG_EXTRA_CONFIGURE_ARGS+="--disable-btls --disable-dynamic-btls" #--with-btls-android-ndk=$ANDROID_NDK"
MININIX_PKG_BUILD_IN_SRC=true

mininix_step_pre_configure () {
#	export CFLAGS="$CFLAGS -mthumb"
	cd "$MININIX_PKG_SRCDIR"
#	NOCONFIGURE=1 ./autogen.sh
#	cp $MININIX_PKG_BUILDER_DIR/{complex,math_private}.h $MININIX_PKG_SRCDIR/support/libm/
	export ANDROID_STANDALONE_TOOLCHAIN=$MININIX_STANDALONE_TOOLCHAIN
}

