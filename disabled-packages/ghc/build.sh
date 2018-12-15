# See https://ghc.haskell.org/trac/ghc/wiki/Building/CrossCompiling
#     https://ghc.haskell.org/trac/ghc/wiki/Building/Preparation/Linux
# and
#     https://github.com/neurocyte/ghc-android
MININIX_PKG_HOMEPAGE=https://www.haskell.org/ghc/
MININIX_PKG_DESCRIPTION="The Glasgow Haskell Compilation system"
MININIX_PKG_VERSION=8.0.1
MININIX_PKG_SRCURL=http://downloads.haskell.org/~ghc/${MININIX_PKG_VERSION}/ghc-${MININIX_PKG_VERSION}-src.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
# Depend on clang for now until llvm is split into separate package:
MININIX_PKG_DEPENDS="clang, ncurses"

MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-iconv-includes=$MININIX_PREFIX/include -with-iconv-libraries=$MININIX_PREFIX/lib"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-curses-includes=$MININIX_PREFIX/include/ncursesw -with-curses-libraries=$MININIX_PREFIX/lib"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --host=x86_64-unknown-linux --build=x86_64-unknown-linux"

mininix_step_post_extract_package() {
	ORIG_CFLAGS="$CFLAGS"
	ORIG_CPPFLAGS="$CPPFLAGS"
	ORIG_LDFLAGS="$LDFLAGS"

	unset AR
	unset AS
	unset CC
	export CFLAGS=""
	unset CPP
	export CPPFLAGS=""
	unset CXXFLAGS
	unset CXX
	export LDFLAGS=""
	unset LD
	unset PKG_CONFIG
	unset RANLIB

	MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --target=${MININIX_HOST_PLATFORM}"
}

mininix_step_pre_configure () {
	echo "INTEGER_LIBRARY = integer-simple" > mk/build.mk
	#echo "GhcStage2HcOpts = $ORIG_CFLAGS $ORIG_CPPFLAGS $ORIG_LDFLAGS" >> mk/build.mk

	# Avoid "Can't use -fPIC or -dynamic on this platform":
	echo "DYNAMIC_GHC_PROGRAMS = NO" >> mk/build.mk
	echo "GhcLibWays = v" >> mk/build.mk
	# "Can not build haddock docs when CrossCompiling or Stage1Only".
	echo "HADDOCK_DOCS=NO" >> mk/build.mk
}
