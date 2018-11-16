LINUXDROID_PKG_HOMEPAGE=https://www.aleksey.com/xmlsec/
LINUXDROID_PKG_DESCRIPTION="XML Security Library"
LINUXDROID_PKG_VERSION=1.2.27
LINUXDROID_PKG_SHA256=97d756bad8e92588e6997d2227797eaa900d05e34a426829b149f65d87118eb6
LINUXDROID_PKG_SRCURL=http://www.aleksey.com/xmlsec/download/xmlsec1-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libxslt, openssl, libgcrypt, libgpg-error"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-crypto-dl
--without-gnutls
"
