MININIX_PKG_HOMEPAGE=https://www.libarchive.org/
MININIX_PKG_DESCRIPTION="Multi-format archive and compression library"
MININIX_PKG_VERSION=3.3.3
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=ba7eb1781c9fbbae178c4c6bad1c6eb08edab9a1496c64833d1715d022b30e2e
MININIX_PKG_SRCURL=https://www.libarchive.org/downloads/libarchive-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libbz2, liblzma, libxml2, openssl"
# --without-nettle to use openssl instead:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--without-nettle
--without-lz4
--without-zstd
"
