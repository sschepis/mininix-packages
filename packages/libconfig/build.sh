MININIX_PKG_HOMEPAGE=https://github.com/hyperrealm/libconfig
MININIX_PKG_DESCRIPTION="C/C++ Configuration File Library"
MININIX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
MININIX_PKG_VERSION=1.7.2
MININIX_PKG_SRCURL=https://github.com/hyperrealm/libconfig/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=f67ac44099916ae260a6c9e290a90809e7d782d96cdd462cac656ebc5b685726

mininix_step_pre_configure() {
	autoreconf -fi
}
