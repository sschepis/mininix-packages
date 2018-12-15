MININIX_PKG_HOMEPAGE=https://www.gnupg.org/
MININIX_PKG_DESCRIPTION="Implementation of the OpenPGP standard for encrypting and signing data and communication"
MININIX_PKG_VERSION=2.2.11
MININIX_PKG_SHA256=496c3e123ef53f35436ddccca58e82acaa901ca4e21174e77386c0cea0c49cd9
MININIX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="libassuan,libbz2,libgcrypt,libksba,libsqlite,libnpth,readline,pinentry,libgpg-error"
MININIX_PKG_CONFLICTS="gnupg2 (<< 2.2.9-1)"
MININIX_PKG_REPLACES="gnupg2 (<< 2.2.9-1)"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ldap
--enable-sqlite
--enable-tofu
"
# Remove non-english help files and man pages shipped with the gnupg (1) package:
MININIX_PKG_RM_AFTER_INSTALL="share/gnupg/help.*.txt share/man/man1/gpg-zip.1 share/man/man7/gnupg.7"

mininix_step_pre_configure() {
	CPPFLAGS+=" -Ddn_skipname=__dn_skipname"
}

mininix_step_post_make_install() {
	cd $MININIX_PREFIX/bin
	ln -sf gpg gpg2
}
