LINUXDROID_PKG_HOMEPAGE=https://wiki.debian.org/Debootstrap
LINUXDROID_PKG_DESCRIPTION="Bootstrap a basic Debian system"
LINUXDROID_PKG_VERSION=1.0.110
LINUXDROID_PKG_SHA256=8a01e4c9f1db8e89c2cd4ef239912f01ef1ba402929a18ba77c96bbc9af07885
LINUXDROID_PKG_SRCURL=http://http.debian.net/debian/pool/main/d/debootstrap/debootstrap_${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="wget, proot, perl"
LINUXDROID_PKG_MAINTAINER="Pierre Rudloff @Rudloff"
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_post_make_install() {
    mkdir -p ${LINUXDROID_PREFIX}/share/man/man8/
    install ${LINUXDROID_PKG_SRCDIR}/debootstrap.8 ${LINUXDROID_PREFIX}/share/man/man8/
}
