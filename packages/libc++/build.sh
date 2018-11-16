LINUXDROID_PKG_HOMEPAGE=https://libcxx.llvm.org/
LINUXDROID_PKG_DESCRIPTION="C++ Standard Library"
LINUXDROID_PKG_VERSION=$LINUXDROID_NDK_VERSION
# Since every C++ package links against this by default (due
# to the libstdc++.so -> libc++_shared.so setup in
# build-package.sh) this package is considered essential,
# and other packages does not need to declare explicit
# dependency on it.
LINUXDROID_PKG_ESSENTIAL=yes

linuxdroid_step_post_massage () {
	mkdir lib
	cp $LINUXDROID_PREFIX/lib/libc++_shared.so lib/
}
