LINUXDROID_PKG_HOMEPAGE=https://redis.io/
LINUXDROID_PKG_DESCRIPTION="In-memory data structure store used as a database, cache and message broker"
LINUXDROID_PKG_VERSION=5.0.1
LINUXDROID_PKG_SHA256=82a67c0eec97f9ad379384c30ec391b269e17a3e4596393c808f02db7595abcb
LINUXDROID_PKG_SRCURL=http://download.redis.io/releases/redis-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_CONFFILES="etc/redis.conf"

linuxdroid_step_pre_configure() {
    export PREFIX=$LINUXDROID_PREFIX
    export USE_JEMALLOC=no

    LDFLAGS+=" -llog"

    if [ $LINUXDROID_ARCH = "i686" ]; then
	    sed -i 's/FINAL_LIBS=-lm/FINAL_LIBS=-lm -latomic/' $LINUXDROID_PKG_SRCDIR/src/Makefile
    fi
}

linuxdroid_step_post_make_install() {
    cp $LINUXDROID_PKG_SRCDIR/redis.conf $LINUXDROID_PREFIX/etc/redis.conf
}
