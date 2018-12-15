MININIX_PKG_HOMEPAGE=https://libcxx.llvm.org/
MININIX_PKG_DESCRIPTION="C++ Standard Library"
MININIX_PKG_VERSION=$MININIX_NDK_VERSION
# Since every C++ package links against this by default (due
# to the libstdc++.so -> libc++_shared.so setup in
# build-package.sh) this package is considered essential,
# and other packages does not need to declare explicit
# dependency on it.
MININIX_PKG_ESSENTIAL=yes

mininix_step_post_massage () {
	mkdir lib
	cp $MININIX_PREFIX/lib/libc++_shared.so lib/
}
