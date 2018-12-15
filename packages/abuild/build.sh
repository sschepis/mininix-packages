MININIX_PKG_HOMEPAGE=https://github.com/alpinelinux/abuild
MININIX_PKG_DESCRIPTION="Build script to build Alpine packages"
MININIX_PKG_VERSION=3.2.0
MININIX_PKG_SHA256=45b26674ca416e71612ff7924169a890a2cc45e945ecca33bc382f98e9ec3eb7
MININIX_PKG_SRCURL=https://github.com/alpinelinux/abuild/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="apk-tools, autoconf, automake, bash, clang, curl, libtool, make, openssl-tool, pkg-config, tar"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_MAKE_ARGS="sysconfdir=$MININIX_PREFIX/etc"
MININIX_PKG_CONFFILES="etc/abuild.conf"

MININIX_PKG_RM_AFTER_INSTALL="
bin/abuild-adduser
bin/abuild-addgroup
bin/abuild-apk
bin/abuild-sudo
bin/buildlab
"

mininix_step_post_make_install() {
    install -Dm600 "$MININIX_PKG_SRCDIR/abuild.conf" "$MININIX_PREFIX/etc/abuild.conf"
}
