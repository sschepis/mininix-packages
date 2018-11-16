LINUXDROID_PKG_HOMEPAGE=https://www.gnupg.org/
LINUXDROID_PKG_DESCRIPTION="Implementation of the OpenPGP standard for encrypting and signing data and communication"
LINUXDROID_PKG_VERSION=2.2.11
LINUXDROID_PKG_SHA256=496c3e123ef53f35436ddccca58e82acaa901ca4e21174e77386c0cea0c49cd9
LINUXDROID_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/gnupg/gnupg-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="libassuan,libbz2,libgcrypt,libksba,libsqlite,libnpth,readline,pinentry,libgpg-error"
LINUXDROID_PKG_CONFLICTS="gnupg2 (<< 2.2.9-1)"
LINUXDROID_PKG_REPLACES="gnupg2 (<< 2.2.9-1)"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ldap
--enable-sqlite
--enable-tofu
"
# Remove non-english help files and man pages shipped with the gnupg (1) package:
LINUXDROID_PKG_RM_AFTER_INSTALL="share/gnupg/help.*.txt share/man/man1/gpg-zip.1 share/man/man7/gnupg.7"

linuxdroid_step_pre_configure() {
	CPPFLAGS+=" -Ddn_skipname=__dn_skipname"
}

linuxdroid_step_post_make_install() {
	cd $LINUXDROID_PREFIX/bin
	ln -sf gpg gpg2
}
