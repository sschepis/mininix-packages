LINUXDROID_PKG_HOMEPAGE=https://github.com/nemtrif/utfcpp
LINUXDROID_PKG_DESCRIPTION="UTF8-CPP: UTF-8 with C++ in a Portable Way"
LINUXDROID_PKG_VERSION=2.3.5
LINUXDROID_PKG_SHA256=f3ffe0ef6c02f48ebafe42369cbd741e844143baad27c13baad1cd14b863983d
LINUXDROID_PKG_SRCURL=https://github.com/nemtrif/utfcpp/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_NO_DEVELSPLIT=yes

linuxdroid_step_configure() {
	return 0;
}

linuxdroid_step_make_install(){
	cp -r source/* $LINUXDROID_PREFIX/include/
}
