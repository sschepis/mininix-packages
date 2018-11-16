LINUXDROID_PKG_HOMEPAGE=https://jonas.github.io/tig/
LINUXDROID_PKG_DESCRIPTION="Ncurses-based text-mode interface for git"
LINUXDROID_PKG_VERSION=2.4.1
LINUXDROID_PKG_SHA256=b6b6aa183e571224d0e1fab3ec482542c1a97fa7a85b26352dc31dbafe8558b8
LINUXDROID_PKG_SRCURL=https://github.com/jonas/tig/releases/download/tig-$LINUXDROID_PKG_VERSION/tig-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="ncurses, git, libandroid-support"

linuxdroid_step_post_make_install () {
        make -j 1 install-doc
}
