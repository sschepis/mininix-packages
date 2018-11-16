LINUXDROID_PKG_HOMEPAGE=https://www.nlnetlabs.nl/projects/ldns/
LINUXDROID_PKG_DESCRIPTION="Library for simplifying DNS programming and supporting recent and experimental RFCs"
LINUXDROID_PKG_DEPENDS="openssl"
LINUXDROID_PKG_VERSION=1.7.0
LINUXDROID_PKG_REVISION=5
LINUXDROID_PKG_SRCURL=https://www.nlnetlabs.nl/downloads/ldns/ldns-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=c19f5b1b4fb374cfe34f4845ea11b1e0551ddc67803bd6ddd5d2a20f0997a6cc
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--with-ssl=$LINUXDROID_PREFIX
--disable-gost
"
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/ldns-config share/man/man1/ldns-config.1"

linuxdroid_step_post_make_install() {
	# The ldns build doesn't install its pkg-config:
	mkdir -p $LINUXDROID_PREFIX/lib/pkgconfig
	cp packaging/libldns.pc $LINUXDROID_PREFIX/lib/pkgconfig/libldns.pc
}
