MININIX_PKG_HOMEPAGE=https://www.privoxy.org
MININIX_PKG_DESCRIPTION="Non-caching web proxy with advanced filtering capabilities"
MININIX_PKG_VERSION=3.0.26
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://www.privoxy.org/sf-download-mirror/Sources/$MININIX_PKG_VERSION%20%28stable%29/privoxy-$MININIX_PKG_VERSION-stable-src.tar.gz
MININIX_PKG_SHA256=57e415b43ee5dfdca74685cc034053eaae962952fdabd086171551a86abf9cd8
MININIX_PKG_CONFFILES='etc/privoxy/config etc/privoxy/match-all.action etc/privoxy/trust etc/privoxy/user.action etc/privoxy/user.filter etc/privoxy/default.action etc/privoxy/default.filter'
MININIX_PKG_REVISION=1
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-dynamic-pcre --sysconfdir=$MININIX_PREFIX/etc/privoxy"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_KEEP_SHARE_DOC=yes

mininix_step_pre_configure() {
    autoheader
    autoconf

    # avoid 'aarch64-linux-android-strip': No such file or directory
    ln -s "$MININIX_STANDALONE_TOOLCHAIN/bin/$STRIP" .
}

mininix_step_post_make_install() {
    # delete link created to avoid errors
    rm -f "$MININIX_PREFIX/sbin/$STRIP"
}

mininix_step_post_massage() {
    # copy default config files
    for f in $MININIX_PKG_CONFFILES; do
        cp "$MININIX_PKG_SRCDIR/$(basename $f)" "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/$f"
    done
}
