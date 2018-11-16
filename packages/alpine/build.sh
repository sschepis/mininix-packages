LINUXDROID_PKG_HOMEPAGE=http://repo.or.cz/alpine.git
LINUXDROID_PKG_DESCRIPTION="Fast, easy to use email client"
LINUXDROID_PKG_VERSION=2.21.9999
LINUXDROID_PKG_SHA256=d5f436019860961f4cb6c9a847e2557e7a284043da59d4fab3263f9796ff646b
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/alpine-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_DEPENDS="libcrypt, ncurses, openssl-tool"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--with-c-client-target=lnx
--without-krb5
--without-ldap
--without-pthread
--without-tcl
--with-system-pinerc=${LINUXDROID_PREFIX}/etc/pine.conf
--with-passfile=$LINUXDROID_ANDROID_HOME/.pine-passfile
"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	export TCC=$CC
	export TRANLIB=$RANLIB
	export SPELLPROG=${LINUXDROID_PREFIX}/bin/hunspell
	export alpine_SSLVERSION=old
	export TPATH=$PATH

	LDFLAGS+=" -lcrypt -llog"

	# To get S_IREAD and friends:
	CPPFLAGS+=" -D__USE_BSD"

	cp $LINUXDROID_PKG_BUILDER_DIR/pine.conf $LINUXDROID_PREFIX/etc/pine.conf

	touch $LINUXDROID_PKG_SRCDIR/imap/lnxok
}

linuxdroid_step_post_configure() {
	cd pith
	$CC_FOR_BUILD help_c_gen.c -o help_c_gen
	$CC_FOR_BUILD help_h_gen.c -o help_h_gen
	touch -d "next hour" help_c_gen help_h_gen
}
linuxdroid_step_create_debscripts () {

        echo "#!$LINUXDROID_PREFIX/bin/sh" >> postinst
	echo "if [ ! -e $LINUXDROID_ANDROID_HOME/.alpine-smime/.pwd/MasterPassword.crt ] && [ ! -e $HOME/.alpine-smime/.pwd/MasterPassword.key ]; then" >> postinst
        echo "echo 'warning making a passwordless masterpasword file'" >> postinst
	echo "mkdir -p \$HOME/.alpine-smime/public \$HOME/.alpine-smime/.pwd \$HOME/.alpine-smime/private \$HOME/.alpine-smime/ca" >> postinst
	echo "openssl req -x509 -newkey rsa:2048 -keyout \$HOME/.alpine-smime/.pwd/MasterPassword.key -out \$HOME/.alpine-smime/.pwd/MasterPassword.crt -days 10000 -nodes -subj '/C=US/ST=dont/L=use/O=this Name/OU=for/CN=anything.com.linuxdroid'" >> postinst
	echo "touch \$HOME/.pine-passfile" >> postinst
	echo "fi" >> postinst
}

