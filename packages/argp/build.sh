LINUXDROID_PKG_HOMEPAGE=https://www.lysator.liu.se/~nisse/misc/
LINUXDROID_PKG_DESCRIPTION="Standalone version of arguments parsing functions from GLIBC"
LINUXDROID_PKG_VERSION=1.3
LINUXDROID_PKG_SHA256=dec79694da1319acd2238ce95df57f3680fea2482096e483323fddf3d818d8be
LINUXDROID_PKG_SRCURL=https://www.lysator.liu.se/~nisse/misc/argp-standalone-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_KEEP_STATIC_LIBRARIES=true
LINUXDROID_PKG_NO_DEVELSPLIT=true

linuxdroid_step_post_make_install() {
        cp libargp.a $LINUXDROID_PREFIX/lib
        cp $LINUXDROID_PKG_SRCDIR/argp.h $LINUXDROID_PREFIX/include
}
