MININIX_PKG_HOMEPAGE=https://wiki.debian.org/Debootstrap
MININIX_PKG_DESCRIPTION="Bootstrap a basic Debian system"
MININIX_PKG_VERSION=1.0.110
MININIX_PKG_SHA256=8a01e4c9f1db8e89c2cd4ef239912f01ef1ba402929a18ba77c96bbc9af07885
MININIX_PKG_SRCURL=http://http.debian.net/debian/pool/main/d/debootstrap/debootstrap_${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="wget, proot, perl"
MININIX_PKG_MAINTAINER="Pierre Rudloff @Rudloff"
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_post_make_install() {
    mkdir -p ${MININIX_PREFIX}/share/man/man8/
    install ${MININIX_PKG_SRCDIR}/debootstrap.8 ${MININIX_PREFIX}/share/man/man8/
}
