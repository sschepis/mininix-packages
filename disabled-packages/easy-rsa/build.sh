MININIX_PKG_HOMEPAGE=https://openvpn.net/easyrsa.html
MININIX_PKG_VERSION=3.0.1
MININIX_PKG_DEPENDS="openssl-tool"
MININIX_PKG_SRCURL=https://github.com/OpenVPN/easy-rsa/releases/download/$MININIX_PKG_VERSION/EasyRSA-$MININIX_PKG_VERSION.tgz
MININIX_PKG_SHA256=dbdaf5b9444b99e0c5221fd4bcf15384c62380c1b63cea23d42239414d7b2d4e
MININIX_PKG_CONFFILES="etc/easy-rsa/openssl-1.0.cnf, etc/easy-rsa/vars"
MININIX_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'
MININIX_PKG_BUILD_IN_SRC=true

mininix_step_make_install () {
    install -D -m0755 easyrsa "${MININIX_PREFIX}"/bin/easyrsa

    install -D -m0644 openssl-1.0.cnf "${MININIX_PREFIX}"/etc/easy-rsa/openssl-1.0.cnf
    install -D -m0644 vars.example "${MININIX_PREFIX}"/etc/easy-rsa/vars
    install -d -m0755 "${MININIX_PREFIX}"/etc/easy-rsa/x509-types/
    install -m0644 x509-types/* "${MININIX_PREFIX}"/etc/easy-rsa/x509-types/
}
