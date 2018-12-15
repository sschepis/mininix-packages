MININIX_PKG_HOMEPAGE=https://www.openssh.com/
MININIX_PKG_DESCRIPTION="Secure shell for logging into a remote machine"
MININIX_PKG_VERSION=7.9p1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=6b4b3ba2253d84ed3771c8050728d597c91cfce898713beb7b64a305b6f11aad
MININIX_PKG_SRCURL=https://fastly.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, ldns, openssl, libedit, libutil, mininix-auth"
MININIX_PKG_CONFLICTS="dropbear"
# --disable-strip to prevent host "install" command to use "-s", which won't work for target binaries:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-etc-default-login
--disable-lastlog
--disable-libutil
--disable-pututline
--disable-pututxline
--disable-strip
--disable-utmp
--disable-utmpx
--disable-wtmp
--disable-wtmpx
--sysconfdir=$MININIX_PREFIX/etc/ssh
--with-cflags=-Dfd_mask=int
--with-ldns
--with-libedit
--with-mantype=man
--without-ssh1
--without-stackprotect
--with-pid-dir=$MININIX_PREFIX/var/run
--with-privsep-path=$MININIX_PREFIX/var/empty
--with-xauth=$MININIX_PREFIX/bin/xauth
ac_cv_func_endgrent=yes
ac_cv_func_fmt_scaled=no
ac_cv_func_getlastlogxbyname=no
ac_cv_func_readpassphrase=no
ac_cv_func_strnvis=no
ac_cv_header_sys_un_h=yes
ac_cv_search_getrrsetbyname=no
ac_cv_func_bzero=yes
"
MININIX_PKG_MAKE_INSTALL_TARGET="install-nokeys"
MININIX_PKG_RM_AFTER_INSTALL="bin/slogin share/man/man1/slogin.1"
MININIX_PKG_CONFFILES="etc/ssh/ssh_config etc/ssh/sshd_config"

mininix_step_pre_configure() {
	autoreconf

    ## Configure script require this variable to set
    ## prefixed path to program 'passwd'
    export PATH_PASSWD_PROG="${MININIX_PREFIX}/bin/passwd"

	CPPFLAGS+=" -DHAVE_ATTRIBUTE__SENTINEL__=1 -DBROKEN_SETRESGID"
	LD=$CC # Needed to link the binaries
	LDFLAGS+=" -llog" # liblog for android logging in syslog hack
}

mininix_step_post_configure() {
	# We need to remove this file before installing, since otherwise the
	# install leaves it alone which means no updated timestamps.
	rm -Rf $MININIX_PREFIX/etc/moduli
}

mininix_step_post_make_install () {
	# "PrintMotd no" is due to our login program already showing it.
	# OpenSSH 7.0 disabled ssh-dss by default, keep it for a while in Mininix:
	echo -e "PrintMotd no\nPasswordAuthentication yes\nPubkeyAcceptedKeyTypes +ssh-dss\nSubsystem sftp $MININIX_PREFIX/libexec/sftp-server" > $MININIX_PREFIX/etc/ssh/sshd_config
	printf "PubkeyAcceptedKeyTypes +ssh-dss\nSendEnv LANG\n" > $MININIX_PREFIX/etc/ssh/ssh_config
	cp $MININIX_PKG_BUILDER_DIR/source-ssh-agent.sh $MININIX_PREFIX/bin/source-ssh-agent
	cp $MININIX_PKG_BUILDER_DIR/ssh-with-agent.sh $MININIX_PREFIX/bin/ssha

	# Install ssh-copy-id:
	cp $MININIX_PKG_SRCDIR/contrib/ssh-copy-id.1 $MININIX_PREFIX/share/man/man1/
	cp $MININIX_PKG_SRCDIR/contrib/ssh-copy-id $MININIX_PREFIX/bin/
	chmod +x $MININIX_PREFIX/bin/ssh-copy-id

	mkdir -p $MININIX_PREFIX/var/run
	echo "OpenSSH needs this folder to put sshd.pid in" >> $MININIX_PREFIX/var/run/README.openssh

	mkdir -p $MININIX_PREFIX/etc/ssh/
	cp $MININIX_PKG_SRCDIR/moduli $MININIX_PREFIX/etc/ssh/moduli
}

mininix_step_post_massage () {
	# Verify that we have man pages packaged (#1538).
	local manpage
	for manpage in ssh-keyscan.1 ssh-add.1 scp.1 ssh-agent.1 ssh.1; do
		if [ ! -f share/man/man1/$manpage ]; then
			mininix_error_exit "Missing man page $manpage"
		fi
	done
}

mininix_step_create_debscripts () {
	echo "#!$MININIX_PREFIX/bin/sh" > postinst
	echo "mkdir -p \$HOME/.ssh" >> postinst
	echo "touch \$HOME/.ssh/authorized_keys" >> postinst
	echo "chmod 700 \$HOME/.ssh" >> postinst
	echo "chmod 600 \$HOME/.ssh/authorized_keys" >> postinst
	echo "" >> postinst
        echo "for a in rsa dsa ecdsa ed25519; do" >> postinst
        echo "    KEYFILE=$MININIX_PREFIX/etc/ssh/ssh_host_\${a}_key" >> postinst
        echo "    test ! -f \$KEYFILE && ssh-keygen -N '' -t \$a -f \$KEYFILE" >> postinst
        echo "done" >> postinst
        echo "exit 0" >> postinst
        chmod 0755 postinst
}
