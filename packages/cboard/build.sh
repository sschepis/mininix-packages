LINUXDROID_PKG_HOMEPAGE=https://benkibbey.wordpress.com/cboard/
LINUXDROID_PKG_DESCRIPTION="PGN browser, editor and chess engine frontend"
LINUXDROID_PKG_VERSION=0.7.3
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/c-board/${LINUXDROID_PKG_VERSION}/cboard-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=8caeabc5cccd35c0f093d36ec0088667530d92e178d328ef345c4c20052d25e2
LINUXDROID_PKG_DEPENDS="libandroid-support,libandroid-glob,gnuchess, ncurses, ncurses-ui-libs"

linuxdroid_step_pre_configure () {
	CFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
	LDFLAGS+=" -landroid-glob"
	if [ "$LINUXDROID_DEBUG" == "true" ]; then
		# When doing debug build, -D_FORTIFY_SOURCE=2 gives this error:
		# /home/builder/.linuxdroid-build/cboard/src/libchess/pgn.c:2235:33: error: 'umask' called with invalid mode
		# mode = umask(600);
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}
