MININIX_PKG_HOMEPAGE=https://notmuchmail.org
MININIX_PKG_DESCRIPTION="Thread-based email index, search and tagging system"
MININIX_PKG_VERSION=0.28
MININIX_PKG_SHA256=acca75cec91651ccd2a7e31f7004e2ae14eff4ae38e375b8a88414c464cd0a37
MININIX_PKG_SRCURL=https://notmuchmail.org/releases/notmuch-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="glib, libgmime, libtalloc, libxapian"

mininix_step_configure () {
	# Use python3 so that the python3-sphinx package is
	# found for man page generation.
	export PYTHON=python3

	cd $MININIX_PKG_SRCDIR
	XAPIAN_CONFIG=$MININIX_PREFIX/bin/xapian-config ./configure \
		--prefix=$MININIX_PREFIX \
		--without-api-docs \
		--without-desktop \
		--without-emacs \
		--without-ruby
}
