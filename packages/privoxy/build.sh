LINUXDROID_PKG_HOMEPAGE=https://www.privoxy.org
LINUXDROID_PKG_DESCRIPTION="Non-caching web proxy with advanced filtering capabilities"
LINUXDROID_PKG_VERSION=3.0.26
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://www.privoxy.org/sf-download-mirror/Sources/$LINUXDROID_PKG_VERSION%20%28stable%29/privoxy-$LINUXDROID_PKG_VERSION-stable-src.tar.gz
LINUXDROID_PKG_SHA256=57e415b43ee5dfdca74685cc034053eaae962952fdabd086171551a86abf9cd8
LINUXDROID_PKG_CONFFILES='etc/privoxy/config etc/privoxy/match-all.action etc/privoxy/trust etc/privoxy/user.action etc/privoxy/user.filter etc/privoxy/default.action etc/privoxy/default.filter'
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-dynamic-pcre --sysconfdir=$LINUXDROID_PREFIX/etc/privoxy"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_KEEP_SHARE_DOC=yes

linuxdroid_step_pre_configure() {
    autoheader
    autoconf

    # avoid 'aarch64-linux-android-strip': No such file or directory
    ln -s "$LINUXDROID_STANDALONE_TOOLCHAIN/bin/$STRIP" .
}

linuxdroid_step_post_make_install() {
    # delete link created to avoid errors
    rm -f "$LINUXDROID_PREFIX/sbin/$STRIP"
}

linuxdroid_step_post_massage() {
    # copy default config files
    for f in $LINUXDROID_PKG_CONFFILES; do
        cp "$LINUXDROID_PKG_SRCDIR/$(basename $f)" "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/$f"
    done
}
