LINUXDROID_PKG_HOMEPAGE=https://memcached.org/
LINUXDROID_PKG_DESCRIPTION="Free & open source, high-performance, distributed memory object caching system"
LINUXDROID_PKG_VERSION=1.5.12
LINUXDROID_PKG_SHA256=c02f97d5685617b209fbe25f3464317b234d765b427d254c2413410a5c095b29
LINUXDROID_PKG_SRCURL=https://www.memcached.org/files/memcached-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libevent, libsasl"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--enable-sasl --disable-coverage"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
    export ac_cv_c_endian=little

    # fix SASL configuration path
    perl -p -i -e "s#/etc/sasl#$LINUXDROID_PREFIX/etc/sasl#" $LINUXDROID_PKG_BUILDDIR/sasl_defs.c

    # getsubopt() taken from https://github.com/lxc/lxc/blob/master/src/include/getsubopt.c
    cp $LINUXDROID_PKG_BUILDER_DIR/getsubopt.c $LINUXDROID_PKG_SRCDIR
    cp $LINUXDROID_PKG_BUILDER_DIR/getsubopt.h $LINUXDROID_PKG_SRCDIR
}
