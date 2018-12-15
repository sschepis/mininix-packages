MININIX_PKG_HOMEPAGE=https://openvpn.net
MININIX_PKG_DESCRIPTION="An easy-to-use, robust, and highly configurable VPN (Virtual Private Network)"
MININIX_PKG_VERSION=2.4.2
MININIX_PKG_DEPENDS="openssl, liblzo, net-tools"
MININIX_PKG_SRCURL=https://swupdate.openvpn.net/community/releases/openvpn-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=df5c4f384b7df6b08a2f6fa8a84b9fd382baf59c2cef1836f82e2a7f62f1bff9
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-plugin-auth-pam
--disable-systemd
--disable-debug
--enable-iproute2
--enable-small
--enable-x509-alt-username
ac_cv_func_getpwnam=yes
ac_cv_func_getpass=yes
IFCONFIG=$MININIX_PREFIX/bin/ifconfig
ROUTE=$MININIX_PREFIX/bin/route
IPROUTE=$MININIX_PREFIX/bin/ip
NETSTAT=$MININIX_PREFIX/bin/netstat"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"

mininix_step_pre_configure () {
    # need to provide getpass, else you "can't get console input"
    cp "$MININIX_PKG_BUILDER_DIR/netbsd_getpass.c" "$MININIX_PKG_SRCDIR/src/openvpn/"

#    CFLAGS="$CFLAGS -DTARGET_ANDROID"
    LDFLAGS="$LDFLAGS -llog "
}

mininix_step_post_make_install () {
    # helper script
    install -m700 "$MININIX_PKG_BUILDER_DIR/mininix-openvpn" "$MININIX_PREFIX/bin/"
    # Install examples
    install -d -m755 "$MININIX_PREFIX/share/openvpn/examples"
    cp "$MININIX_PKG_SRCDIR"/sample/sample-config-files/* "$MININIX_PREFIX/share/openvpn/examples"
}
