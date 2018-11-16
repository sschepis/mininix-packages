LINUXDROID_PKG_HOMEPAGE=https://github.com/hyperrealm/libconfig
LINUXDROID_PKG_DESCRIPTION="C/C++ Configuration File Library"
LINUXDROID_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
LINUXDROID_PKG_VERSION=1.7.2
LINUXDROID_PKG_SRCURL=https://github.com/hyperrealm/libconfig/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=f67ac44099916ae260a6c9e290a90809e7d782d96cdd462cac656ebc5b685726

linuxdroid_step_pre_configure() {
	autoreconf -fi
}
