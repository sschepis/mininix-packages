MININIX_PKG_HOMEPAGE=https://lz4.github.io/lz4/
MININIX_PKG_DESCRIPTION="Fast LZ compression algorithm library"
MININIX_PKG_VERSION=1.8.3
MININIX_PKG_SHA256=33af5936ac06536805f9745e0b6d61da606a1f8b4cc5c04dd3cbaca3b9b4fc43
MININIX_PKG_SRCURL=https://github.com/lz4/lz4/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	MININIX_PKG_SRCDIR+=lib
}
