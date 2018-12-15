MININIX_PKG_HOMEPAGE=https://github.com/nemtrif/utfcpp
MININIX_PKG_DESCRIPTION="UTF8-CPP: UTF-8 with C++ in a Portable Way"
MININIX_PKG_VERSION=2.3.5
MININIX_PKG_SHA256=f3ffe0ef6c02f48ebafe42369cbd741e844143baad27c13baad1cd14b863983d
MININIX_PKG_SRCURL=https://github.com/nemtrif/utfcpp/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_NO_DEVELSPLIT=yes

mininix_step_configure() {
	return 0;
}

mininix_step_make_install(){
	cp -r source/* $MININIX_PREFIX/include/
}
