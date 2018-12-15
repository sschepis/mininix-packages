MININIX_PKG_HOMEPAGE=https://memcached.org/
MININIX_PKG_DESCRIPTION="Free & open source, high-performance, distributed memory object caching system"
MININIX_PKG_VERSION=1.5.12
MININIX_PKG_SHA256=c02f97d5685617b209fbe25f3464317b234d765b427d254c2413410a5c095b29
MININIX_PKG_SRCURL=https://www.memcached.org/files/memcached-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libevent, libsasl"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--enable-sasl --disable-coverage"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
    export ac_cv_c_endian=little

    # fix SASL configuration path
    perl -p -i -e "s#/etc/sasl#$MININIX_PREFIX/etc/sasl#" $MININIX_PKG_BUILDDIR/sasl_defs.c

    # getsubopt() taken from https://github.com/lxc/lxc/blob/master/src/include/getsubopt.c
    cp $MININIX_PKG_BUILDER_DIR/getsubopt.c $MININIX_PKG_SRCDIR
    cp $MININIX_PKG_BUILDER_DIR/getsubopt.h $MININIX_PKG_SRCDIR
}
