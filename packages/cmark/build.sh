MININIX_PKG_HOMEPAGE=https://github.com/github/cmark
MININIX_PKG_DESCRIPTION="CommonMark parsing and rendering program"
MININIX_PKG_VERSION=0.28.3.gfm.19
MININIX_PKG_SHA256=d2c8cb255e227d07533a32cfd4a052e189f697e2a9681d8b17d15654259e2e4b
MININIX_PKG_SRCURL=https://github.com/github/cmark/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_INSTALL_LIBDIR=$MININIX_PREFIX/lib"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="lib/cmake-gfm-extensions"

mininix_step_post_make_install() {
    cd $MININIX_PREFIX/bin
    ln -f -s cmark-gfm cmark

    cd $MININIX_PREFIX/share/man/man1
    ln -f -s cmark-gfm.1 cmark.1
}
