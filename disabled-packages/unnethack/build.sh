# Crashes with "Dungeon description not valid"
MININIX_PKG_HOMEPAGE=http://sourceforge.net/apps/trac/unnethack
MININIX_PKG_DESCRIPTION="Dungeon crawling game, fork of NetHack"
MININIX_PKG_VERSION=5.1.0
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/unnethack/unnethack/${MININIX_PKG_VERSION}/unnethack-${MININIX_PKG_VERSION}-20131208.tar.gz
# --with-owner=$USER to avoid unnethack trying to use a "games" user, --with-groups to avoid "bin" group
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-owner=$USER --with-group=`groups | cut -d ' ' -f 1`"
MININIX_PKG_DEPENDS="gsl, ncurses"

# unnethack builds util/{makedefs,lev_comp,dgn_comp} binaries which are later used during the build.
# we first build these host tools in $MININIX_PKG_TMPDIR/host-build and copy them into the ordinary
# cross compile tree after configure, bumping their modification time so that they do not get rebuilt.

CFLAGS="$CFLAGS $CPPFLAGS $LDFLAGS"
export LFLAGS="$LDFLAGS"
LD="$CC"

mininix_step_pre_configure () {
	# Create a host build for the makedefs binary
	mkdir $MININIX_PKG_TMPDIR/host-build
	cd $MININIX_PKG_TMPDIR/host-build
	ORIG_CC=$CC; export CC=gcc
	ORIG_CFLAGS=$CFLAGS; export CFLAGS=""
	ORIG_CPPFLAGS=$CPPFLAGS; export CPPFLAGS=""
	ORIG_CXXFLAGS=$CXXFLAGS; export CXXFLAGS=""
	ORIG_LDFLAGS=$LDFLAGS; export LDFLAGS=""
	ORIG_LFLAGS=$LFLAGS; export LFLAGS=""
	$MININIX_PKG_SRCDIR/configure --with-owner=$USER
	make
	make spec_levs
	make dungeon
	set +e
	make dlb
	set -e
	export CC=$ORIG_CC
	export CFLAGS=$ORIG_CFLAGS
	export CPPFLAGS=$ORIG_CPPFLAGS
	export CXXFLAGS=$ORIG_CXXFLAGS
	export LDFLAGS=$ORIG_LDFLAGS
	export LFLAGS=$ORIG_LFLAGS
}

mininix_step_post_configure () {
	# Use the host built makedefs
	cp $MININIX_PKG_TMPDIR/host-build/util/makedefs $MININIX_PKG_BUILDDIR/util/makedefs
	cp $MININIX_PKG_TMPDIR/host-build/util/lev_comp $MININIX_PKG_BUILDDIR/util/lev_comp
	cp $MININIX_PKG_TMPDIR/host-build/util/dgn_comp $MININIX_PKG_BUILDDIR/util/dgn_comp
	cp $MININIX_PKG_TMPDIR/host-build/util/dlb $MININIX_PKG_BUILDDIR/util/dlb
	# Update timestamp so the binary does not get rebuilt
        touch -d "next hour" $MININIX_PKG_BUILDDIR/util/makedefs $MININIX_PKG_BUILDDIR/util/lev_comp $MININIX_PKG_BUILDDIR/util/dgn_comp $MININIX_PKG_BUILDDIR/util/dlb
}

mininix_step_post_make_install () {
	# Add directory which must exist:
	mkdir -p $MININIX_PREFIX/var/unnethack/level
	echo "This directory stores locks" > $MININIX_PREFIX/var/unnethack/level/README
}
