LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/libtool/
LINUXDROID_PKG_DESCRIPTION="Generic library support script hiding the complexity of using shared libraries behind a consistent, portable interface"
LINUXDROID_PKG_VERSION=2.4.6
LINUXDROID_PKG_REVISION=5
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtool/libtool-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3
LINUXDROID_PKG_DEPENDS="bash,grep,sed,libltdl"
LINUXDROID_PKG_NO_DEVELSPLIT=yes
LINUXDROID_PKG_CONFLICTS="libtool-dev"
LINUXDROID_PKG_REPLACES="libtool-dev"

linuxdroid_step_post_make_install () {
	perl -p -i -e "s|\"/bin/|\"$LINUXDROID_PREFIX/bin/|" $LINUXDROID_PREFIX/bin/{libtool,libtoolize}
}
