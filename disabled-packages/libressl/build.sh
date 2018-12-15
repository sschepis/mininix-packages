# Status: Mininix currently uses openssl. Transitioning to libressl
#         is tempting, but on hold for now to see how widespread
#         the adoption of libressl in Linux distributions is.
MININIX_PKG_HOMEPAGE=http://www.libressl.org/
MININIX_PKG_DESCRIPTION="Library implementing the TLS protocol as well as general purpose cryptography functions"
MININIX_PKG_DEPENDS="ca-certificates"
MININIX_PKG_VERSION=2.5.5
MININIX_PKG_SHA256=e57f5e3d5842a81fe9351b6e817fcaf0a749ca4ef35a91465edba9e071dce7c4
MININIX_PKG_SRCURL=http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-openssldir=$MININIX_PREFIX/etc/tls"
MININIX_PKG_CONFLICTS="openssl"
# etc/tls/cert.pem is provided by ca-certificates:
MININIX_PKG_RM_AFTER_INSTALL="etc/tls/cert.pem"

mininix_step_pre_configure() {
	CPPFLAGS+=" -DNO_SYSLOG"
}
