LINUXDROID_PKG_HOMEPAGE=https://github.com/KittyKatt/screenFetch
LINUXDROID_PKG_DESCRIPTION="Bash Screenshot Information Tool"
LINUXDROID_PKG_DEPENDS="bash"
LINUXDROID_PKG_VERSION=3.8.0
LINUXDROID_PKG_SRCURL=https://github.com/KittyKatt/screenFetch/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=248283ee3c24b0dbffb79ed685bdd518554073090c1c167d07ad2a729db26633
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_MAINTAINER="Pierre Rudloff @Rudloff"
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
    install screenfetch-dev ${LINUXDROID_PREFIX}/bin/screenfetch
    install screenfetch.1 ${LINUXDROID_PREFIX}/share/man/man1/
}
