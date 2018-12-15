MININIX_PKG_HOMEPAGE=http://www.digip.org/jansson/
MININIX_PKG_DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
MININIX_PKG_VERSION=2.12
MININIX_PKG_SHA256=76260d30e9bbd0ef392798525e8cd7fe59a6450c54ca6135672e3cd6a1642941
MININIX_PKG_SRCURL=https://github.com/akheron/jansson/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	autoreconf -fi
}
