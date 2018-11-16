LINUXDROID_PKG_HOMEPAGE=https://nghttp2.org/
LINUXDROID_PKG_DESCRIPTION="nghttp HTTP 2.0 library"
LINUXDROID_PKG_VERSION=1.34.0
LINUXDROID_PKG_SHA256=ecb0c013141495e24bd6deca022b5a92097a7848a0c17c4e5af1243a97fa622e
LINUXDROID_PKG_SRCURL=https://github.com/nghttp2/nghttp2/releases/download/v${LINUXDROID_PKG_VERSION}/nghttp2-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"
# The tools are not built due to --enable-lib-only:
LINUXDROID_PKG_RM_AFTER_INSTALL="share/man/man1 share/nghttp2/fetch-ocsp-response"
