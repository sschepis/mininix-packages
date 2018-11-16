LINUXDROID_PKG_HOMEPAGE=http://elinks.or.cz
LINUXDROID_PKG_DESCRIPTION="Full-Featured Text WWW Browser"
_COMMIT=f86be659718c0cd0a67f88b42f07044c23d0d028
LINUXDROID_PKG_VERSION=0.13.GIT
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://github.com/xeffyr/elinks/archive/${_COMMIT}.zip
LINUXDROID_PKG_SHA256=3e65aaabcc4f6b2418643cf965786c00e3f196330f3e7863ca83f9e546d5e609
LINUXDROID_PKG_DEPENDS="libexpat, libidn, openssl, libbz2"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--enable-256-colors
--enable-true-color
--mandir=$LINUXDROID_PREFIX/share/man
--with-openssl
--without-brotli
--without-gc
"
LINUXDROID_MAKE_PROCESSES=1

linuxdroid_step_pre_configure() {
    ./autogen.sh
}
