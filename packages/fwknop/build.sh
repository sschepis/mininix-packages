MININIX_PKG_HOMEPAGE=https://www.cipherdyne.org/fwknop/
MININIX_PKG_DESCRIPTION="fwknop: Single Packet Authorization > Port Knocking"
MININIX_PKG_VERSION=2.6.10
MININIX_PKG_SHA256=f6c09bec97ed8e474a98ae14f9f53e1bcdda33393f20667b6af3fb6bb894ca77
MININIX_PKG_SRCURL=https://www.cipherdyne.org/fwknop/download/fwknop-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="gpgme"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-server
--with-gpgme
--with-gpg=$MININIX_PREFIX/bin/gpg2
"
