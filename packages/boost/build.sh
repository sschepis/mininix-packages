MININIX_PKG_HOMEPAGE=https://boost.org
MININIX_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
MININIX_PKG_VERSION=1.68.0
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=7f6130bc3cf65f56a618888ce9d5ea704fa10b462be126ad053e80e553d6d8b7
MININIX_PKG_SRCURL=https://dl.bintray.com/boostorg/release/$MININIX_PKG_VERSION/source/boost_${MININIX_PKG_VERSION//./_}.tar.bz2
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="libbz2, liblzma"
MININIX_PKG_BUILD_DEPENDS="python, python2"
MININIX_PKG_BREAKS="libboost-python (<= 1.65.1-2)"
MININIX_PKG_REPLACES="libboost-python (<= 1.65.1-2)"

mininix_step_make_install() {
	CXXFLAGS+=" -std=c++14"

	rm $MININIX_PREFIX/lib/libboost* -f
	rm $MININIX_PREFIX/include/boost -rf

	./bootstrap.sh
	echo "using clang : $MININIX_ARCH : $CXX : <linkflags>-L/data/data/com.mininix/files/usr/lib ; " >> project-config.jam
	echo "using python : 3.7 : $MININIX_PREFIX/bin/python3 : $MININIX_PREFIX/include/python3.7m : $MININIX_PREFIX/lib ;" >> project-config.jam

	if [ "$MININIX_ARCH" = arm ] || [ "$MININIX_ARCH" = aarch64 ]; then
		BOOSTARCH=arm
		BOOSTABI=aapcs
	elif [ "$MININIX_ARCH" = i686 ] || [ "$MININIX_ARCH" = x86_64 ]; then
		BOOSTARCH=x86
		BOOSTABI=sysv
	fi

	if [ "$MININIX_ARCH" = x86_64 ] || [ "$MININIX_ARCH" = aarch64 ]; then
		BOOSTAM=64
	elif [ "$MININIX_ARCH" = i686 ] || [ "$MININIX_ARCH" = arm ]; then
		BOOSTAM=32
	fi

	./b2 target-os=android -j${MININIX_MAKE_PROCESSES} \
		include=/data/data/com.mininix/files/usr/include \
		toolset=clang-$MININIX_ARCH \
		--prefix="$MININIX_PREFIX"  \
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
	echo "using clang : $MININIX_ARCH : $CXX : <linkflags>-L/data/data/com.mininix/files/usr/lib ; " >> project-config.jam
	echo "using python : 2.7 : $MININIX_PREFIX/bin/python2 : $MININIX_PREFIX/include/python2.7 : $MININIX_PREFIX/lib ;" >> project-config.jam

	./b2 target-os=android -j${MININIX_MAKE_PROCESSES} \
		include=/data/data/com.mininix/files/usr/include \
		toolset=clang-$MININIX_ARCH \
		--stagedir="$MININIX_PREFIX"  \
		-q \
		-a \
		--disable-icu \
		cxxflags="$CXXFLAGS" \
		link=shared \
		threading=multi \
		boost.locale.icu=off \
		stage
}
