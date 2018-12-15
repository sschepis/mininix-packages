MININIX_PKG_HOMEPAGE=https://github.com/open-source-parsers/jsoncpp
MININIX_PKG_DESCRIPTION="C++ library for interacting with JSON"
MININIX_PKG_VERSION=1.8.4
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=c49deac9e0933bcb7044f08516861a2d560988540b23de2ac1ad443b219afdb6
MININIX_PKG_SRCURL=https://github.com/open-source-parsers/jsoncpp/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DJSONCPP_WITH_TESTS=OFF
-DCCACHE_FOUND=OFF
"

mininix_step_pre_configure () {
	# The installation does not overwrite symlinks such as libjsoncpp.so.1,
	# so if rebuilding these are not detected as modified. Fix that:
	rm -f $MININIX_PREFIX/lib/libjsoncpp.so*
}
