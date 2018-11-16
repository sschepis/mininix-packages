LINUXDROID_PKG_HOMEPAGE=https://www.openssh.com/
LINUXDROID_PKG_DESCRIPTION="Secure shell for logging into a remote machine"
LINUXDROID_PKG_VERSION=7.9p1
LINUXDROID_PKG_SHA256=6b4b3ba2253d84ed3771c8050728d597c91cfce898713beb7b64a305b6f11aad
LINUXDROID_PKG_SRCURL=https://fastly.cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, ldns, openssl, libedit, libutil"
LINUXDROID_PKG_CONFLICTS="dropbear"
# --disable-strip to prevent host "install" command to use "-s", which won't work for target binaries:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
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
--sysconfdir=$LINUXDROID_PREFIX/etc/ssh
--with-cflags=-Dfd_mask=int
--with-ldns
--with-libedit
--with-mantype=man
--without-ssh1
--without-stackprotect
--with-pid-dir=$LINUXDROID_PREFIX/var/run
--with-privsep-path=$LINUXDROID_PREFIX/var/empty
--with-xauth=$LINUXDROID_PREFIX/bin/xauth
ac_cv_func_endgrent=yes
ac_cv_func_fmt_scaled=no
ac_cv_func_getlastlogxbyname=no
ac_cv_func_readpassphrase=no
ac_cv_func_strnvis=no
ac_cv_header_sys_un_h=yes
ac_cv_search_getrrsetbyname=no
ac_cv_func_bzero=yes
"
LINUXDROID_PKG_MAKE_INSTALL_TARGET="install-nokeys"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/slogin share/man/man1/slogin.1"
LINUXDROID_PKG_CONFFILES="etc/ssh/ssh_config etc/ssh/sshd_config"

linuxdroid_step_pre_configure() {
	autoreconf

    ## Configure script require this variable to set
    ## prefixed path to program 'passwd'
    export PATH_PASSWD_PROG="${LINUXDROID_PREFIX}/bin/passwd"

	CPPFLAGS+=" -DHAVE_ATTRIBUTE__SENTINEL__=1 -DBROKEN_SETRESGID"
	LD=$CC # Needed to link the binaries
	LDFLAGS+=" -llog" # liblog for android logging in syslog hack
}

linuxdroid_step_post_configure() {
	# We need to remove this file before installing, since otherwise the
	# install leaves it alone which means no updated timestamps.
	rm -Rf $LINUXDROID_PREFIX/etc/moduli
}

linuxdroid_step_post_make_install () {
	# "PrintMotd no" is due to our login program already showing it.
	# OpenSSH 7.0 disabled ssh-dss by default, keep it for a while in Linuxdroid:
	echo -e "PrintMotd no\nPasswordAuthentication no\nPubkeyAcceptedKeyTypes +ssh-dss\nSubsystem sftp $LINUXDROID_PREFIX/libexec/sftp-server" > $LINUXDROID_PREFIX/etc/ssh/sshd_config
	printf "PubkeyAcceptedKeyTypes +ssh-dss\nSendEnv LANG\n" > $LINUXDROID_PREFIX/etc/ssh/ssh_config
	cp $LINUXDROID_PKG_BUILDER_DIR/source-ssh-agent.sh $LINUXDROID_PREFIX/bin/source-ssh-agent
	cp $LINUXDROID_PKG_BUILDER_DIR/ssh-with-agent.sh $LINUXDROID_PREFIX/bin/ssha

	# Install ssh-copy-id:
	cp $LINUXDROID_PKG_SRCDIR/contrib/ssh-copy-id.1 $LINUXDROID_PREFIX/share/man/man1/
	cp $LINUXDROID_PKG_SRCDIR/contrib/ssh-copy-id $LINUXDROID_PREFIX/bin/
	chmod +x $LINUXDROID_PREFIX/bin/ssh-copy-id

	mkdir -p $LINUXDROID_PREFIX/var/run
	echo "OpenSSH needs this folder to put sshd.pid in" >> $LINUXDROID_PREFIX/var/run/README.openssh

	mkdir -p $LINUXDROID_PREFIX/etc/ssh/
	cp $LINUXDROID_PKG_SRCDIR/moduli $LINUXDROID_PREFIX/etc/ssh/moduli
}

linuxdroid_step_post_massage () {
	# Verify that we have man pages packaged (#1538).
	local manpage
	for manpage in ssh-keyscan.1 ssh-add.1 scp.1 ssh-agent.1 ssh.1; do
		if [ ! -f share/man/man1/$manpage ]; then
			linuxdroid_error_exit "Missing man page $manpage"
		fi
	done
}

linuxdroid_step_create_debscripts () {
	echo "#!$LINUXDROID_PREFIX/bin/sh" > postinst
	echo "mkdir -p \$HOME/.ssh" >> postinst
	echo "touch \$HOME/.ssh/authorized_keys" >> postinst
	echo "chmod 700 \$HOME/.ssh" >> postinst
	echo "chmod 600 \$HOME/.ssh/authorized_keys" >> postinst
	echo "" >> postinst
        echo "for a in rsa dsa ecdsa ed25519; do" >> postinst
        echo "    KEYFILE=$LINUXDROID_PREFIX/etc/ssh/ssh_host_\${a}_key" >> postinst
        echo "    test ! -f \$KEYFILE && ssh-keygen -N '' -t \$a -f \$KEYFILE" >> postinst
        echo "done" >> postinst
        echo "exit 0" >> postinst
        chmod 0755 postinst
}
