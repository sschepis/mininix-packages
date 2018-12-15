MININIX_PKG_HOMEPAGE=https://www.wireguard.com
MININIX_PKG_DESCRIPTION="Tools for the WireGuard secure network tunnel"
MININIX_PKG_VERSION=0.0.20181119
MININIX_PKG_SHA256=7d47f7996dd291069de4efb3097c42f769f60dc3ac6f850a4d5705f321e4406b
MININIX_PKG_SRCURL=https://git.zx2c4.com/WireGuard/snapshot/WireGuard-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_DEPENDS="libmnl, tsu"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_MAKE_ARGS=" -C src/tools WITH_BASHCOMPLETION=yes WITH_WGQUICK=no WITH_SYSTEMDUNITS=no"

mininix_step_post_make_install () {
    cd src/tools/wg-quick
    $CC $CFLAGS -DWG_CONFIG_SEARCH_PATHS="\"$MININIX_ANDROID_HOME/.wireguard $MININIX_PREFIX/etc/wireguard /data/misc/wireguard /data/data/com.wireguard.android/files\"" -o wg-quick android.c
    install -m 0755 wg-quick $MININIX_PREFIX/bin
}
