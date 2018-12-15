MININIX_PKG_HOMEPAGE=https://www.cups.org
MININIX_PKG_VERSION=2.2.4
MININIX_PKG_DEPENDS=krb5
MININIX_PKG_SRCURL=https://github.com/apple/cups/releases/download/v$MININIX_PKG_VERSION/cups-$MININIX_PKG_VERSION-source.tar.gz
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_SHA256=596d4db72651c335469ae5f37b0da72ac9f97d73e30838d787065f559dea98cc
MININIX_PKG_DEPENDS="libandroid-support, libcrypt"
MININIX_PKG_FOLDERNAME=cups-$MININIX_PKG_VERSION
MININIX_PKG_BUILD_IN_SRC=true
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-option-checking
--disable-gssapi
--with-components=core
"

mininix_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog -lcrypt"
}

mininix_step_post_make_install () {
	mv "$MININIX_PREFIX"/lib64/libcups.so* "$MININIX_PREFIX"/lib/
}
