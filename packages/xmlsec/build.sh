MININIX_PKG_HOMEPAGE=https://www.aleksey.com/xmlsec/
MININIX_PKG_DESCRIPTION="XML Security Library"
MININIX_PKG_VERSION=1.2.27
MININIX_PKG_SHA256=97d756bad8e92588e6997d2227797eaa900d05e34a426829b149f65d87118eb6
MININIX_PKG_SRCURL=http://www.aleksey.com/xmlsec/download/xmlsec1-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libxslt, openssl, libgcrypt, libgpg-error"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-crypto-dl
--without-gnutls
"
