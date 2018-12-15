MININIX_PKG_HOMEPAGE=https://redis.io/
MININIX_PKG_DESCRIPTION="In-memory data structure store used as a database, cache and message broker"
MININIX_PKG_VERSION=5.0.2
MININIX_PKG_SHA256=937dde6164001c083e87316aa20dad2f8542af089dfcb1cbb64f9c8300cd00ed
MININIX_PKG_SRCURL=http://download.redis.io/releases/redis-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_CONFFILES="etc/redis.conf"

mininix_step_pre_configure() {
    export PREFIX=$MININIX_PREFIX
    export USE_JEMALLOC=no

    LDFLAGS+=" -llog"

    if [ $MININIX_ARCH = "i686" ]; then
	    sed -i 's/FINAL_LIBS=-lm/FINAL_LIBS=-lm -latomic/' $MININIX_PKG_SRCDIR/src/Makefile
    fi
}

mininix_step_post_make_install() {
    cp $MININIX_PKG_SRCDIR/redis.conf $MININIX_PREFIX/etc/redis.conf
}
