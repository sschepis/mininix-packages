LINUXDROID_PKG_HOMEPAGE=https://www.cups.org
LINUXDROID_PKG_VERSION=2.2.4
LINUXDROID_PKG_DEPENDS=krb5
LINUXDROID_PKG_SRCURL=https://github.com/apple/cups/releases/download/v$LINUXDROID_PKG_VERSION/cups-$LINUXDROID_PKG_VERSION-source.tar.gz
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_SHA256=596d4db72651c335469ae5f37b0da72ac9f97d73e30838d787065f559dea98cc
LINUXDROID_PKG_DEPENDS="libandroid-support, libcrypt"
LINUXDROID_PKG_FOLDERNAME=cups-$LINUXDROID_PKG_VERSION
LINUXDROID_PKG_BUILD_IN_SRC=true
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-option-checking
--disable-gssapi
--with-components=core
"

linuxdroid_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog -lcrypt"
}

linuxdroid_step_post_make_install () {
	mv "$LINUXDROID_PREFIX"/lib64/libcups.so* "$LINUXDROID_PREFIX"/lib/
}
