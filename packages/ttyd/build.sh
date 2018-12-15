MININIX_PKG_HOMEPAGE=https://tsl0922.github.io/ttyd/
MININIX_PKG_DESCRIPTION="Command-line tool for sharing terminal over the web"
MININIX_PKG_VERSION=1.4.2
MININIX_PKG_SHA256=ff1a66b418df6cd741868a8ea84f69cd63f15e52e3fa117641ec57d3c37a1315
MININIX_PKG_SRCURL=https://github.com/tsl0922/ttyd/archive/$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="json-c, libwebsockets, libutil"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_XXD=$MININIX_PKG_TMPDIR/xxd"

mininix_step_pre_configure() {
	mininix_download \
		https://raw.githubusercontent.com/vim/vim/v8.1.0427/src/xxd/xxd.c \
		$MININIX_PKG_CACHEDIR/xxd.c \
		021b38e02cd31951a80ef5185271d71f2def727eb8ff65b7a07aecfbd688b8e1
	gcc $MININIX_PKG_CACHEDIR/xxd.c -o $MININIX_PKG_TMPDIR/xxd
}
