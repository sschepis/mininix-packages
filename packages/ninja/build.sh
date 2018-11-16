LINUXDROID_PKG_HOMEPAGE=https://ninja-build.org
LINUXDROID_PKG_DESCRIPTION="A small build system with a focus on speed"
LINUXDROID_PKG_VERSION=1.8.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=86b8700c3d0880c2b44c2ff67ce42774aaf8c28cbf57725cb881569288c1c6f4
LINUXDROID_PKG_SRCURL=https://github.com/ninja-build/ninja/archive/v${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_configure () {
	$LINUXDROID_PKG_SRCDIR/configure.py
}

linuxdroid_step_make () {
	linuxdroid_setup_ninja
	ninja -j $LINUXDROID_MAKE_PROCESSES
}

linuxdroid_step_make_install () {
	cp ninja $LINUXDROID_PREFIX/bin
}
