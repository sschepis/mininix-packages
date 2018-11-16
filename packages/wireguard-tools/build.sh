LINUXDROID_PKG_HOMEPAGE=https://www.wireguard.com
LINUXDROID_PKG_DESCRIPTION="Tools for the WireGuard secure network tunnel"
LINUXDROID_PKG_VERSION=0.0.20181018
LINUXDROID_PKG_SHA256=af05824211b27cbeeea2b8d6b76be29552c0d80bfe716471215e4e43d259e327
LINUXDROID_PKG_SRCURL=https://git.zx2c4.com/WireGuard/snapshot/WireGuard-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_DEPENDS="libmnl, tsu"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_MAKE_ARGS=" -C src/tools WITH_BASHCOMPLETION=yes WITH_WGQUICK=no WITH_SYSTEMDUNITS=no"

linuxdroid_step_post_make_install () {
    cd src/tools/wg-quick
    $CC $CFLAGS -DWG_CONFIG_SEARCH_PATHS="\"$LINUXDROID_ANDROID_HOME/.wireguard $LINUXDROID_PREFIX/etc/wireguard /data/misc/wireguard /data/data/com.wireguard.android/files\"" -o wg-quick android.c
    install -m 0755 wg-quick $LINUXDROID_PREFIX/bin
}
