LINUXDROID_PKG_HOMEPAGE=https://tsl0922.github.io/ttyd/
LINUXDROID_PKG_DESCRIPTION="Command-line tool for sharing terminal over the web"
LINUXDROID_PKG_VERSION=1.4.2
LINUXDROID_PKG_SHA256=ff1a66b418df6cd741868a8ea84f69cd63f15e52e3fa117641ec57d3c37a1315
LINUXDROID_PKG_SRCURL=https://github.com/tsl0922/ttyd/archive/$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="json-c, libwebsockets, libutil"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_XXD=$LINUXDROID_PKG_TMPDIR/xxd"

linuxdroid_step_pre_configure() {
	linuxdroid_download \
		https://raw.githubusercontent.com/vim/vim/v8.1.0427/src/xxd/xxd.c \
		$LINUXDROID_PKG_CACHEDIR/xxd.c \
		021b38e02cd31951a80ef5185271d71f2def727eb8ff65b7a07aecfbd688b8e1
	gcc $LINUXDROID_PKG_CACHEDIR/xxd.c -o $LINUXDROID_PKG_TMPDIR/xxd
}
