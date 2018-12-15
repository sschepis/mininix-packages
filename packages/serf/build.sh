MININIX_PKG_HOMEPAGE=https://serf.apache.org/
MININIX_PKG_DESCRIPTION="High performance C-based HTTP client library"
MININIX_PKG_VERSION=1.3.9
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://archive.apache.org/dist/serf/serf-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_SHA256=549c2d21c577a8a9c0450facb5cca809f26591f048e466552240947bdf7a87cc
MININIX_PKG_DEPENDS="apr, apr-util, openssl"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make_install () {
	scons APR=$MININIX_PREFIX \
	      APU=$MININIX_PREFIX \
	      CC=`which $CC` \
	      CFLAGS="$CFLAGS" \
	      CPPFLAGS="$CPPFLAGS -std=c11" \
	      LINKFLAGS="$LDFLAGS" \
	      OPENSSL=$MININIX_PREFIX \
	      PREFIX=$MININIX_PREFIX \
	      install
	# Avoid specifying -lcrypt:
	perl -p -i -e 's/-lcrypt //' $MININIX_PREFIX/lib/pkgconfig/serf-1.pc
}
