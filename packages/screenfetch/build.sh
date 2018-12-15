MININIX_PKG_HOMEPAGE=https://github.com/KittyKatt/screenFetch
MININIX_PKG_DESCRIPTION="Bash Screenshot Information Tool"
MININIX_PKG_DEPENDS="bash"
MININIX_PKG_VERSION=3.8.0
MININIX_PKG_SRCURL=https://github.com/KittyKatt/screenFetch/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=248283ee3c24b0dbffb79ed685bdd518554073090c1c167d07ad2a729db26633
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_MAINTAINER="Pierre Rudloff @Rudloff"
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
    install screenfetch-dev ${MININIX_PREFIX}/bin/screenfetch
    install screenfetch.1 ${MININIX_PREFIX}/share/man/man1/
}
