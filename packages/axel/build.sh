MININIX_PKG_HOMEPAGE=https://github.com/axel-download-accelerator/axel
MININIX_PKG_DESCRIPTION="light command line download accelerator"
MININIX_PKG_VERSION=2.16.1
MININIX_PKG_REVISION=1
MININIX_PKG_MAINTAINER="lokesh @hax4us"
MININIX_PKG_DEPENDS="openssl"
MININIX_PKG_BUILD_DEPENDS="pkg-config, gettext"
MININIX_PKG_SHA256=675a8608ffa305b98624a3c2684c84e4696572e3fd7dce6d12e0a9b61d64b67f
MININIX_PKG_SRCURL=https://github.com/axel-download-accelerator/axel/releases/download/v${MININIX_PKG_VERSION}/axel-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS=" --disable-nls"
