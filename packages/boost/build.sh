LINUXDROID_PKG_HOMEPAGE=https://boost.org
LINUXDROID_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
LINUXDROID_PKG_VERSION=1.68.0
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=7f6130bc3cf65f56a618888ce9d5ea704fa10b462be126ad053e80e553d6d8b7
LINUXDROID_PKG_SRCURL=https://dl.bintray.com/boostorg/release/$LINUXDROID_PKG_VERSION/source/boost_${LINUXDROID_PKG_VERSION//./_}.tar.bz2
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="libbz2, liblzma"
LINUXDROID_PKG_BUILD_DEPENDS="python, python2"
LINUXDROID_PKG_BREAKS="libboost-python (<= 1.65.1-2)"
LINUXDROID_PKG_REPLACES="libboost-python (<= 1.65.1-2)"

linuxdroid_step_make_install() {
	CXXFLAGS+=" -std=c++14"

	rm $LINUXDROID_PREFIX/lib/libboost* -f
	rm $LINUXDROID_PREFIX/include/boost -rf

	./bootstrap.sh
	echo "using clang : $LINUXDROID_ARCH : $CXX : <linkflags>-L/data/data/com.linuxdroid/files/usr/lib ; " >> project-config.jam
	echo "using python : 3.7 : $LINUXDROID_PREFIX/bin/python3 : $LINUXDROID_PREFIX/include/python3.7m : $LINUXDROID_PREFIX/lib ;" >> project-config.jam

	if [ "$LINUXDROID_ARCH" = arm ] || [ "$LINUXDROID_ARCH" = aarch64 ]; then
		BOOSTARCH=arm
		BOOSTABI=aapcs
	elif [ "$LINUXDROID_ARCH" = i686 ] || [ "$LINUXDROID_ARCH" = x86_64 ]; then
		BOOSTARCH=x86
		BOOSTABI=sysv
	fi

	if [ "$LINUXDROID_ARCH" = x86_64 ] || [ "$LINUXDROID_ARCH" = aarch64 ]; then
		BOOSTAM=64
	elif [ "$LINUXDROID_ARCH" = i686 ] || [ "$LINUXDROID_ARCH" = arm ]; then
		BOOSTAM=32
	fi

	./b2 target-os=android -j${LINUXDROID_MAKE_PROCESSES} \
		include=/data/data/com.linuxdroid/files/usr/include \
		toolset=clang-$LINUXDROID_ARCH \
		--prefix="$LINUXDROID_PREFIX"  \
		-q \
		--without-stacktrace \
		--without-log \
		--disable-icu \
		cxxflags="$CXXFLAGS" \
		architecture="$BOOSTARCH" \
		abi="$BOOSTABI" \
		address-model="$BOOSTAM" \
		boost.locale.icu=off \
		binary-format=elf \
		link=shared \
		threading=multi \
		install

	./bootstrap.sh --with-libraries=python
	echo "using clang : $LINUXDROID_ARCH : $CXX : <linkflags>-L/data/data/com.linuxdroid/files/usr/lib ; " >> project-config.jam
	echo "using python : 2.7 : $LINUXDROID_PREFIX/bin/python2 : $LINUXDROID_PREFIX/include/python2.7 : $LINUXDROID_PREFIX/lib ;" >> project-config.jam

	./b2 target-os=android -j${LINUXDROID_MAKE_PROCESSES} \
		include=/data/data/com.linuxdroid/files/usr/include \
		toolset=clang-$LINUXDROID_ARCH \
		--stagedir="$LINUXDROID_PREFIX"  \
		-q \
		-a \
		--disable-icu \
		cxxflags="$CXXFLAGS" \
		link=shared \
		threading=multi \
		boost.locale.icu=off \
		stage
}
