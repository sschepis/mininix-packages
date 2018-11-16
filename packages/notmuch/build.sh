LINUXDROID_PKG_HOMEPAGE=https://notmuchmail.org
LINUXDROID_PKG_DESCRIPTION="Thread-based email index, search and tagging system"
LINUXDROID_PKG_VERSION=0.28
LINUXDROID_PKG_SHA256=acca75cec91651ccd2a7e31f7004e2ae14eff4ae38e375b8a88414c464cd0a37
LINUXDROID_PKG_SRCURL=https://notmuchmail.org/releases/notmuch-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="glib, libgmime, libtalloc, libxapian"

linuxdroid_step_configure () {
	# Use python3 so that the python3-sphinx package is
	# found for man page generation.
	export PYTHON=python3

	cd $LINUXDROID_PKG_SRCDIR
	XAPIAN_CONFIG=$LINUXDROID_PREFIX/bin/xapian-config ./configure \
		--prefix=$LINUXDROID_PREFIX \
		--without-api-docs \
		--without-desktop \
		--without-emacs \
		--without-ruby
}
