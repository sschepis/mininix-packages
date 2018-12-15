MININIX_PKG_HOMEPAGE=https://www.nlnetlabs.nl/projects/ldns/
MININIX_PKG_DESCRIPTION="Library for simplifying DNS programming and supporting recent and experimental RFCs"
MININIX_PKG_DEPENDS="openssl"
MININIX_PKG_VERSION=1.7.0
MININIX_PKG_REVISION=5
MININIX_PKG_SRCURL=https://www.nlnetlabs.nl/downloads/ldns/ldns-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=c19f5b1b4fb374cfe34f4845ea11b1e0551ddc67803bd6ddd5d2a20f0997a6cc
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--with-ssl=$MININIX_PREFIX
--disable-gost
"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/ldns-config share/man/man1/ldns-config.1"

mininix_step_post_make_install() {
	# The ldns build doesn't install its pkg-config:
	mkdir -p $MININIX_PREFIX/lib/pkgconfig
	cp packaging/libldns.pc $MININIX_PREFIX/lib/pkgconfig/libldns.pc
}
