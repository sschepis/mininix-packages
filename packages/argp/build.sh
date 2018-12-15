MININIX_PKG_HOMEPAGE=https://www.lysator.liu.se/~nisse/misc/
MININIX_PKG_DESCRIPTION="Standalone version of arguments parsing functions from GLIBC"
MININIX_PKG_VERSION=1.3
MININIX_PKG_SHA256=dec79694da1319acd2238ce95df57f3680fea2482096e483323fddf3d818d8be
MININIX_PKG_SRCURL=https://www.lysator.liu.se/~nisse/misc/argp-standalone-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_KEEP_STATIC_LIBRARIES=true
MININIX_PKG_NO_DEVELSPLIT=true

mininix_step_post_make_install() {
        cp libargp.a $MININIX_PREFIX/lib
        cp $MININIX_PKG_SRCDIR/argp.h $MININIX_PREFIX/include
}
