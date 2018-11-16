LINUXDROID_PKG_HOMEPAGE=https://openvpn.net/easyrsa.html
LINUXDROID_PKG_VERSION=3.0.1
LINUXDROID_PKG_DEPENDS="openssl-tool"
LINUXDROID_PKG_SRCURL=https://github.com/OpenVPN/easy-rsa/releases/download/$LINUXDROID_PKG_VERSION/EasyRSA-$LINUXDROID_PKG_VERSION.tgz
LINUXDROID_PKG_SHA256=dbdaf5b9444b99e0c5221fd4bcf15384c62380c1b63cea23d42239414d7b2d4e
LINUXDROID_PKG_CONFFILES="etc/easy-rsa/openssl-1.0.cnf, etc/easy-rsa/vars"
LINUXDROID_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'
LINUXDROID_PKG_BUILD_IN_SRC=true

linuxdroid_step_make_install () {
    install -D -m0755 easyrsa "${LINUXDROID_PREFIX}"/bin/easyrsa

    install -D -m0644 openssl-1.0.cnf "${LINUXDROID_PREFIX}"/etc/easy-rsa/openssl-1.0.cnf
    install -D -m0644 vars.example "${LINUXDROID_PREFIX}"/etc/easy-rsa/vars
    install -d -m0755 "${LINUXDROID_PREFIX}"/etc/easy-rsa/x509-types/
    install -m0644 x509-types/* "${LINUXDROID_PREFIX}"/etc/easy-rsa/x509-types/
}
