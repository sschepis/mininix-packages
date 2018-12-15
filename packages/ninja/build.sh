MININIX_PKG_HOMEPAGE=https://ninja-build.org
MININIX_PKG_DESCRIPTION="A small build system with a focus on speed"
MININIX_PKG_VERSION=1.8.2
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=86b8700c3d0880c2b44c2ff67ce42774aaf8c28cbf57725cb881569288c1c6f4
MININIX_PKG_SRCURL=https://github.com/ninja-build/ninja/archive/v${MININIX_PKG_VERSION}.tar.gz

mininix_step_configure () {
	$MININIX_PKG_SRCDIR/configure.py
}

mininix_step_make () {
	mininix_setup_ninja
	ninja -j $MININIX_MAKE_PROCESSES
}

mininix_step_make_install () {
	cp ninja $MININIX_PREFIX/bin
}
