MININIX_PKG_HOMEPAGE=https://www.pureftpd.org/project/pure-ftpd
MININIX_PKG_DESCRIPTION="Pure-FTPd is a free (BSD), secure, production-quality and standard-conformant FTP server"
MININIX_PKG_VERSION=1.0.47
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=4740c316f5df879a2d68464489fb9b8b90113fe7dce58e2cdd2054a4768f27ad
MININIX_PKG_DEPENDS="libcrypt, openssl"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_elf_elf_begin=no
ac_cv_lib_sodium_crypto_pwhash_scryptsalsa208sha256_str=no
--with-ftpwho
--with-minimal
--with-nonroot
--with-puredb
--with-tls
"
MININIX_PKG_CONFFILES="etc/pure-ftpd.conf"
