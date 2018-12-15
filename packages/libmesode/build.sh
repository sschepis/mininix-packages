MININIX_PKG_HOMEPAGE=https://github.com/boothj5/libmesode
MININIX_PKG_DESCRIPTION="Minimal XMPP library written for use with Profanity XMPP client"
MININIX_PKG_VERSION=0.9.2
MININIX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MININIX_PKG_SRCURL=https://github.com/boothj5/libmesode/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=79bdf92e287d8891a8eb89d84a8b1bb1c3f61ded322630f583ec1d1c00d99123
MININIX_PKG_DEPENDS="openssl,libexpat"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
./bootstrap.sh
}
