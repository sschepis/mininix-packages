LINUXDROID_PKG_HOMEPAGE=https://serf.apache.org/
LINUXDROID_PKG_DESCRIPTION="High performance C-based HTTP client library"
LINUXDROID_PKG_VERSION=1.3.9
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://archive.apache.org/dist/serf/serf-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=549c2d21c577a8a9c0450facb5cca809f26591f048e466552240947bdf7a87cc
LINUXDROID_PKG_DEPENDS="apr, apr-util, openssl"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make_install () {
	scons APR=$LINUXDROID_PREFIX \
	      APU=$LINUXDROID_PREFIX \
	      CC=`which $CC` \
	      CFLAGS="$CFLAGS" \
	      CPPFLAGS="$CPPFLAGS -std=c11" \
	      LINKFLAGS="$LDFLAGS" \
	      OPENSSL=$LINUXDROID_PREFIX \
	      PREFIX=$LINUXDROID_PREFIX \
	      install
	# Avoid specifying -lcrypt:
	perl -p -i -e 's/-lcrypt //' $LINUXDROID_PREFIX/lib/pkgconfig/serf-1.pc
}
