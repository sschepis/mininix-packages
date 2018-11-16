LINUXDROID_PKG_HOMEPAGE=https://web.mit.edu/kerberos
LINUXDROID_PKG_DESCRIPTION="The Kerberos network authentication system"
LINUXDROID_PKG_VERSION=1.16.2
LINUXDROID_PKG_SHA256=9f721e1fe593c219174740c71de514c7228a97d23eb7be7597b2ae14e487f027
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/krb5-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, libandroid-glob, readline, openssl, libutil, libdb"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_CONFFILES="etc/krb5.conf var/krb5kdc/kdc.conf"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-readline
--without-system-verto
--with-netlib=-lc
--enable-dns-for-realm
--sbindir=$LINUXDROID_PREFIX/bin
--with-size-optimizations
--with-system-db
DEFCCNAME=$LINUXDROID_PREFIX/tmp/krb5cc_%{uid}
DEFKTNAME=$LINUXDROID_PREFIX/etc/krb5.keytab
DEFCKTNAME=$LINUXDROID_PREFIX/var/krb5/user/%{euid}/client.keytab
"

linuxdroid_step_post_extract_package() {
	LINUXDROID_PKG_SRCDIR+="/src"
}

linuxdroid_step_pre_configure () {
	# cannot test these when cross compiling
	export krb5_cv_attr_constructor_destructor='yes,yes'
	export ac_cv_func_regcomp='yes'
	export ac_cv_printf_positional='yes'

	# bionic doesn't have getpass
	cp "$LINUXDROID_PKG_BUILDER_DIR/netbsd_getpass.c" "$LINUXDROID_PKG_SRCDIR/clients/kpasswd/"

	CFLAGS="$CFLAGS -D_PASSWORD_LEN=PASS_MAX"
	LDFLAGS="$LDFLAGS -landroid-glob -llog"
}

linuxdroid_step_post_make_install () {
	# Enable logging to STDERR by default
	echo -e "\tdefault = STDERR" >> $LINUXDROID_PKG_SRCDIR/config-files/krb5.conf

	# Sample KDC config file
	install -dm 700 $LINUXDROID_PREFIX/var/krb5kdc
	install -pm 600 $LINUXDROID_PKG_SRCDIR/config-files/kdc.conf $LINUXDROID_PREFIX/var/krb5kdc/kdc.conf

	# Default configuration file
	install -pm 600 $LINUXDROID_PKG_SRCDIR/config-files/krb5.conf $LINUXDROID_PREFIX/etc/krb5.conf

	install -dm 700 $LINUXDROID_PREFIX/share/aclocal
	install -m 600 $LINUXDROID_PKG_SRCDIR/util/ac_check_krb5.m4 $LINUXDROID_PREFIX/share/aclocal
}
