LINUXDROID_PKG_HOMEPAGE=https://micro-editor.github.io/
LINUXDROID_PKG_DESCRIPTION="Modern and intuitive terminal-based text editor"
LINUXDROID_PKG_VERSION=1.4.1
LINUXDROID_PKG_SHA256=0b516826226cf1ddf2fbb274f049cab456a5c162efe3d648f0871564fadcf812
LINUXDROID_PKG_SRCURL=https://github.com/zyedidia/micro/releases/download/v${LINUXDROID_PKG_VERSION}/micro-${LINUXDROID_PKG_VERSION}-src.tar.gz

linuxdroid_step_make() {
	return
}

linuxdroid_step_make_install() {
	linuxdroid_setup_golang

	export GOPATH=$LINUXDROID_PKG_BUILDDIR
	local MICRO_SRC=$GOPATH/src/github.com/zyedidia/micro

	cd $LINUXDROID_PKG_SRCDIR
	mkdir -p $MICRO_SRC
	cp -R . $MICRO_SRC

	cd $MICRO_SRC
	make build-quick
	mv micro $LINUXDROID_PREFIX/bin/micro
}
