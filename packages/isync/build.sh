MININIX_PKG_HOMEPAGE=http://isync.sourceforge.net
MININIX_PKG_DESCRIPTION="IMAP and MailDir mailbox synchronizer"
MININIX_PKG_VERSION=1.3.0
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/isync/isync/${MININIX_PKG_VERSION}/isync-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=8d5f583976e3119705bdba27fa4fc962e807ff5996f24f354957178ffa697c9c
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-sasl ac_cv_header_db=no ac_cv_berkdb4=no"
MININIX_PKG_DEPENDS="openssl"
