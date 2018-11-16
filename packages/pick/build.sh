LINUXDROID_PKG_HOMEPAGE=https://github.com/calleerlandsson/pick
LINUXDROID_PKG_DESCRIPTION="Utility to choose one option from a set of choices with fuzzy search functionality"
LINUXDROID_PKG_VERSION=2.0.2
LINUXDROID_PKG_SHA256=f2b43aaa540ad3ff05a256a531c2f47d3d95145b82c1d1b0d62dfb40d793d385
LINUXDROID_PKG_SRCURL=https://github.com/calleerlandsson/pick/releases/download/v${LINUXDROID_PKG_VERSION}/pick-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_search_setupterm=-lncurses"
