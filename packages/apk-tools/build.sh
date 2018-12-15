MININIX_PKG_HOMEPAGE=https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
MININIX_PKG_DESCRIPTION="Alpine Linux package management tools"
MININIX_PKG_VERSION=2.10.3
MININIX_PKG_SHA256=f91861ed981d0a2912d5d860a33795ec40d16021ab03f6561a3849b9c0bcf77e
MININIX_PKG_SRCURL=https://github.com/alpinelinux/apk-tools/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="openssl"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_MAKE_ARGS="LUAAPK="
MININIX_PKG_CONFFILES="etc/apk/repositories"

mininix_step_post_make_install() {
    mkdir -p $MININIX_PREFIX/etc/apk/
    echo $MININIX_ARCH > $MININIX_PREFIX/etc/apk/arch

    echo "https://mininix.net/apk/main" > $MININIX_PREFIX/etc/apk/repositories
}

mininix_step_post_massage() {
    mkdir -p "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/etc/apk/keys"
    mkdir -p "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/etc/apk/protected_paths.d"
    mkdir -p "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/lib/apk/db/"
    mkdir -p "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/var/cache/apk"

    ln -sfr \
        "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/var/cache/apk" \
        "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/etc/apk/cache"
}

mininix_step_create_debscripts() {
    {
        echo "#!$MININIX_PREFIX/bin/sh"
        echo "touch $MININIX_PREFIX/etc/apk/world"
    } > ./postinst
    chmod 755 postinst
}
