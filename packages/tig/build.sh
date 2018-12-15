MININIX_PKG_HOMEPAGE=https://jonas.github.io/tig/
MININIX_PKG_DESCRIPTION="Ncurses-based text-mode interface for git"
MININIX_PKG_VERSION=2.4.1
MININIX_PKG_SHA256=b6b6aa183e571224d0e1fab3ec482542c1a97fa7a85b26352dc31dbafe8558b8
MININIX_PKG_SRCURL=https://github.com/jonas/tig/releases/download/tig-$MININIX_PKG_VERSION/tig-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="ncurses, git, libandroid-support"

mininix_step_post_make_install () {
        make -j 1 install-doc
}
