LINUXDROID_PKG_HOMEPAGE=https://github.com/linuxdroid/libandroid-support
LINUXDROID_PKG_DESCRIPTION="Library extending the Android C library (Bionic) for additional multibyte, locale and math support"
LINUXDROID_PKG_VERSION=22
LINUXDROID_PKG_SHA256=667f20d0821a6305c50c667363486d546b293e846f31d02f559947d50121f51e
LINUXDROID_PKG_SRCURL=https://github.com/linuxdroid/libandroid-support/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_ESSENTIAL=yes

linuxdroid_step_make_install () {
	_C_FILES="src/musl-*/*.c"
	$CC $CFLAGS -std=c99 -DNULL=0 $CPPFLAGS $LDFLAGS \
		-Iinclude \
		$_C_FILES \
		-shared -fpic \
		-o libandroid-support.so

	cp libandroid-support.so $LINUXDROID_PREFIX/lib/

	(cd $LINUXDROID_PREFIX/lib; ln -f -s libandroid-support.so libiconv.so; )

	rm -Rf $LINUXDROID_PREFIX/include/libandroid-support
	mkdir -p $LINUXDROID_PREFIX/include/libandroid-support
	cp -Rf include/* $LINUXDROID_PREFIX/include/libandroid-support/

	(cd $LINUXDROID_PREFIX/include; ln -f -s libandroid-support/iconv.h iconv.h)
}
