LINUXDROID_PKG_HOMEPAGE=https://github.com/JuliaLang/utf8proc
LINUXDROID_PKG_DESCRIPTION="Library for processing UTF-8 Unicode data"
LINUXDROID_PKG_VERSION=2.2.0
LINUXDROID_PKG_SHA256=3f8fd1dbdb057ee5ba584a539d5cd1b3952141c0338557cb0bdf8cb9cfed5dbf
LINUXDROID_PKG_SRCURL=https://github.com/JuliaLang/utf8proc/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	rm $LINUXDROID_PKG_SRCDIR/CMakeLists.txt
}
