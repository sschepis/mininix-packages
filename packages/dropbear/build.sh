LINUXDROID_PKG_HOMEPAGE=https://matt.ucc.asn.au/dropbear/dropbear.html
LINUXDROID_PKG_DESCRIPTION="Small SSH server and client"
LINUXDROID_PKG_DEPENDS="libutil"
LINUXDROID_PKG_CONFLICTS="openssh"
LINUXDROID_PKG_VERSION=2018.76
LINUXDROID_PKG_REVISION=4
LINUXDROID_PKG_SRCURL=https://matt.ucc.asn.au/dropbear/releases/dropbear-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=f2fb9167eca8cf93456a5fc1d4faf709902a3ab70dd44e352f3acbc3ffdaea65
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-syslog --disable-utmp --disable-utmpx --disable-wtmp"
LINUXDROID_PKG_BUILD_IN_SRC="yes"
# Avoid linking to libcrypt for server password authentication:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# build a multi-call binary
LINUXDROID_PKG_EXTRA_MAKE_ARGS="MULTI=1"

linuxdroid_step_post_make_install() {
    ln -sf "dropbearmulti" "${LINUXDROID_PREFIX}/bin/ssh"
}

linuxdroid_step_create_debscripts () {
    {
        echo "#!$LINUXDROID_PREFIX/bin/sh"
        echo "mkdir -p $LINUXDROID_PREFIX/etc/dropbear"
        echo "for a in rsa dss ecdsa; do"
        echo "    KEYFILE=$LINUXDROID_PREFIX/etc/dropbear/dropbear_\${a}_host_key"
        echo "    test ! -f \$KEYFILE && dropbearkey -t \$a -f \$KEYFILE"
        echo "done"
        echo "exit 0"
    } > postinst
    chmod 0755 postinst
}
