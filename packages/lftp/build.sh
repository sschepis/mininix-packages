LINUXDROID_PKG_HOMEPAGE=https://lftp.tech/
LINUXDROID_PKG_DESCRIPTION="FTP/HTTP client and file transfer program"
LINUXDROID_PKG_VERSION=4.8.4
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=4ebc271e9e5cea84a683375a0f7e91086e5dac90c5d51bb3f169f75386107a62
LINUXDROID_PKG_SRCURL=https://lftp.tech/ftp/lftp-${LINUXDROID_PKG_VERSION}.tar.xz
# (1) Android has dn_expand, but lftp assumes that dn_skipname then exists, which it does not on android.
# (2) Use --with-openssl to use openssl instead of gnutls.
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_dn_expand=no
--with-openssl
--with-expat=$LINUXDROID_PREFIX
--with-readline=$LINUXDROID_PREFIX
"
LINUXDROID_PKG_DEPENDS="libexpat, openssl, readline, libutil, libidn2"
LINUXDROID_PKG_BUILD_DEPENDS="ncurses-dev"

linuxdroid_step_pre_configure () {
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --with-zlib=$LINUXDROID_STANDALONE_TOOLCHAIN/sysroot/usr"
	if [ "$LINUXDROID_DEBUG" == "true" ]; then
		# When doing debug build, -D_FORTIFY_SOURCE=2 gives this error:
		# /home/builder/.linuxdroid-build/_lib/16-aarch64-21-v3/bin/../sysroot/usr/include/bits/fortify/string.h:79:26: error: use of undeclared identifier '__USE_FORTIFY_LEVEL'
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi

	CXXFLAGS+=" -DNO_INLINE_GETPASS=1"
}
