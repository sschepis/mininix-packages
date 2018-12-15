MININIX_PKG_HOMEPAGE=https://www.mpfr.org/
MININIX_PKG_DESCRIPTION="C library for multiple-precision floating-point computations with correct rounding"
MININIX_PKG_DEPENDS="libgmp"
MININIX_PKG_VERSION=4.0.1
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/mpfr/mpfr-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=67874a60826303ee2fb6affc6dc0ddd3e749e9bfcb4c8655e3953d0458a6e16e
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_locale_h=no"
