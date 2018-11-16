LINUXDROID_PKG_HOMEPAGE=http://net-tools.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="Configuration tools for Linux networking"
LINUXDROID_PKG_VERSION=1.60.2017.02.21
LINUXDROID_PKG_REVISION=1
local commit=479bb4a7e11a4084e2935c0a576388f92469225b
LINUXDROID_PKG_SHA256=7e9f8e8dcbabed0c8eeb976100496567abae7ac9d92c72cebd1a9d965473e943
# We use a mirror to avoid using
# https://sourceforge.net/code-snapshots/git/n/ne/net-tools/code.git/net-tools-code-$commit.zip
# which does not work all the time (sourceforge caching system):
LINUXDROID_PKG_SRCURL=https://dl.bintray.com/linuxdroid/upstream/net-tools-code-${commit}.zip
LINUXDROID_PKG_BUILD_IN_SRC=true
LINUXDROID_PKG_EXTRA_MAKE_ARGS="BINDIR=$LINUXDROID_PREFIX/bin SBINDIR=$LINUXDROID_PREFIX/bin HAVE_HOSTNAME_TOOLS=0"

linuxdroid_step_configure () {
	CFLAGS="$CFLAGS -D_LINUX_IN6_H -Dindex=strchr -Drindex=strrchr"
	LDFLAGS="$LDFLAGS -llog"
	sed -i "s#/usr#$LINUXDROID_PREFIX#" $LINUXDROID_PKG_SRCDIR/man/Makefile
	yes "" | make config || true
}

linuxdroid_step_make_install () {
	make $LINUXDROID_PKG_EXTRA_MAKE_ARGS update
}
