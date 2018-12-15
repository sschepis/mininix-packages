MININIX_PKG_HOMEPAGE=https://nghttp2.org/
MININIX_PKG_DESCRIPTION="nghttp HTTP 2.0 library"
MININIX_PKG_VERSION=1.35.0
MININIX_PKG_SHA256=23610ddd446bf1a9ae12905b0e7f283afd46249794868b7acd581e693900544c
MININIX_PKG_SRCURL=https://github.com/nghttp2/nghttp2/releases/download/v${MININIX_PKG_VERSION}/nghttp2-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"
# The tools are not built due to --enable-lib-only:
MININIX_PKG_RM_AFTER_INSTALL="share/man/man1 share/nghttp2/fetch-ocsp-response"
