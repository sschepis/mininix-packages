# Status: Does not work with openssl 1.1 or later.
LINUXDROID_PKG_HOMEPAGE=http://www.webdav.org/cadaver/
LINUXDROID_PKG_DESCRIPTION="cadaver is a command-line WebDAV client for Unix"
LINUXDROID_PKG_VERSION=0.23.3
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/www/old/cadaver-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_SHA256=123772d7d33f06a76742dba874b1c444423b52ad3a7bbb87559616ec78b9ae5e
LINUXDROID_PKG_DEPENDS="openssl, libxml2, ncurses, readline"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--with-libxml2
--without-gssapi
--with-ssl=openssl
"

linuxdroid_step_pre_configure() {
    export ac_cv_func_setlocale=no
}
