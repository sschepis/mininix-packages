LINUXDROID_PKG_HOMEPAGE=https://github.com/github/cmark
LINUXDROID_PKG_DESCRIPTION="CommonMark parsing and rendering program"
LINUXDROID_PKG_VERSION=0.28.3.gfm.19
LINUXDROID_PKG_SHA256=d2c8cb255e227d07533a32cfd4a052e189f697e2a9681d8b17d15654259e2e4b
LINUXDROID_PKG_SRCURL=https://github.com/github/cmark/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_INSTALL_LIBDIR=$LINUXDROID_PREFIX/lib"
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="lib/cmake-gfm-extensions"

linuxdroid_step_post_make_install() {
    cd $LINUXDROID_PREFIX/bin
    ln -f -s cmark-gfm cmark

    cd $LINUXDROID_PREFIX/share/man/man1
    ln -f -s cmark-gfm.1 cmark.1
}
