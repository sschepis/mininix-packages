LINUXDROID_PKG_HOMEPAGE=https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management
LINUXDROID_PKG_DESCRIPTION="Alpine Linux package management tools"
LINUXDROID_PKG_VERSION=2.10.1
LINUXDROID_PKG_SHA256=278854c4ee21ed4ddb7605ef09190385106c6fdfc10526e32e0108ad0f12509a
LINUXDROID_PKG_SRCURL=https://github.com/alpinelinux/apk-tools/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="openssl"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_MAKE_ARGS="LUAAPK="

linuxdroid_step_post_make_install() {
    mkdir -p $LINUXDROID_PREFIX/etc/apk/
    echo $LINUXDROID_ARCH > $LINUXDROID_PREFIX/etc/apk/arch

    mkdir -p $LINUXDROID_PREFIX/lib/apk/db/
    echo "Needed by the apk tool." > $LINUXDROID_PREFIX/lib/apk/db/README
}

