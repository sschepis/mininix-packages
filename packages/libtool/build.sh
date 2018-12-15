MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/libtool/
MININIX_PKG_DESCRIPTION="Generic library support script hiding the complexity of using shared libraries behind a consistent, portable interface"
MININIX_PKG_VERSION=2.4.6
MININIX_PKG_REVISION=5
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/libtool/libtool-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3
MININIX_PKG_DEPENDS="bash,grep,sed,libltdl"
MININIX_PKG_NO_DEVELSPLIT=yes
MININIX_PKG_CONFLICTS="libtool-dev"
MININIX_PKG_REPLACES="libtool-dev"

mininix_step_post_make_install () {
	perl -p -i -e "s|\"/bin/|\"$MININIX_PREFIX/bin/|" $MININIX_PREFIX/bin/{libtool,libtoolize}
}
