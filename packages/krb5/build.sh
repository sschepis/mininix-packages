MININIX_PKG_HOMEPAGE=https://web.mit.edu/kerberos
MININIX_PKG_DESCRIPTION="The Kerberos network authentication system"
MININIX_PKG_VERSION=1.16.2
MININIX_PKG_SHA256=9f721e1fe593c219174740c71de514c7228a97d23eb7be7597b2ae14e487f027
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/krb5-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, libandroid-glob, readline, openssl, libutil, libdb"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_CONFFILES="etc/krb5.conf var/krb5kdc/kdc.conf"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-readline
--without-system-verto
--with-netlib=-lc
--enable-dns-for-realm
--sbindir=$MININIX_PREFIX/bin
--with-size-optimizations
--with-system-db
DEFCCNAME=$MININIX_PREFIX/tmp/krb5cc_%{uid}
DEFKTNAME=$MININIX_PREFIX/etc/krb5.keytab
DEFCKTNAME=$MININIX_PREFIX/var/krb5/user/%{euid}/client.keytab
"

mininix_step_post_extract_package() {
	MININIX_PKG_SRCDIR+="/src"
}

mininix_step_pre_configure () {
	# cannot test these when cross compiling
	export krb5_cv_attr_constructor_destructor='yes,yes'
	export ac_cv_func_regcomp='yes'
	export ac_cv_printf_positional='yes'

	# bionic doesn't have getpass
	cp "$MININIX_PKG_BUILDER_DIR/netbsd_getpass.c" "$MININIX_PKG_SRCDIR/clients/kpasswd/"

	CFLAGS="$CFLAGS -D_PASSWORD_LEN=PASS_MAX"
	LDFLAGS="$LDFLAGS -landroid-glob -llog"
}

mininix_step_post_make_install () {
	# Enable logging to STDERR by default
	echo -e "\tdefault = STDERR" >> $MININIX_PKG_SRCDIR/config-files/krb5.conf

	# Sample KDC config file
	install -dm 700 $MININIX_PREFIX/var/krb5kdc
	install -pm 600 $MININIX_PKG_SRCDIR/config-files/kdc.conf $MININIX_PREFIX/var/krb5kdc/kdc.conf

	# Default configuration file
	install -pm 600 $MININIX_PKG_SRCDIR/config-files/krb5.conf $MININIX_PREFIX/etc/krb5.conf

	install -dm 700 $MININIX_PREFIX/share/aclocal
	install -m 600 $MININIX_PKG_SRCDIR/util/ac_check_krb5.m4 $MININIX_PREFIX/share/aclocal
}
