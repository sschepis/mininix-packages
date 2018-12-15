MININIX_PKG_HOMEPAGE=https://github.com/mininix/libandroid-support
MININIX_PKG_DESCRIPTION="Library extending the Android C library (Bionic) for additional multibyte, locale and math support"
MININIX_PKG_VERSION=22
MININIX_PKG_SHA256=667f20d0821a6305c50c667363486d546b293e846f31d02f559947d50121f51e
MININIX_PKG_SRCURL=https://github.com/mininix/libandroid-support/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_ESSENTIAL=yes

mininix_step_make_install () {
	_C_FILES="src/musl-*/*.c"
	$CC $CFLAGS -std=c99 -DNULL=0 $CPPFLAGS $LDFLAGS \
		-Iinclude \
		$_C_FILES \
		-shared -fpic \
		-o libandroid-support.so

	cp libandroid-support.so $MININIX_PREFIX/lib/

	(cd $MININIX_PREFIX/lib; ln -f -s libandroid-support.so libiconv.so; )

	rm -Rf $MININIX_PREFIX/include/libandroid-support
	mkdir -p $MININIX_PREFIX/include/libandroid-support
	cp -Rf include/* $MININIX_PREFIX/include/libandroid-support/

	(cd $MININIX_PREFIX/include; ln -f -s libandroid-support/iconv.h iconv.h)
}
