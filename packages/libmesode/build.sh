LINUXDROID_PKG_HOMEPAGE=https://github.com/boothj5/libmesode
LINUXDROID_PKG_DESCRIPTION="Minimal XMPP library written for use with Profanity XMPP client"
LINUXDROID_PKG_VERSION=0.9.2
LINUXDROID_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
LINUXDROID_PKG_SRCURL=https://github.com/boothj5/libmesode/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=79bdf92e287d8891a8eb89d84a8b1bb1c3f61ded322630f583ec1d1c00d99123
LINUXDROID_PKG_DEPENDS="openssl,libexpat"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
./bootstrap.sh
}
