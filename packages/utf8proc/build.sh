MININIX_PKG_HOMEPAGE=https://github.com/JuliaLang/utf8proc
MININIX_PKG_DESCRIPTION="Library for processing UTF-8 Unicode data"
MININIX_PKG_VERSION=2.2.0
MININIX_PKG_SHA256=3f8fd1dbdb057ee5ba584a539d5cd1b3952141c0338557cb0bdf8cb9cfed5dbf
MININIX_PKG_SRCURL=https://github.com/JuliaLang/utf8proc/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	rm $MININIX_PKG_SRCDIR/CMakeLists.txt
}
