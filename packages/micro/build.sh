MININIX_PKG_HOMEPAGE=https://micro-editor.github.io/
MININIX_PKG_DESCRIPTION="Modern and intuitive terminal-based text editor"
MININIX_PKG_VERSION=1.4.1
MININIX_PKG_SHA256=0b516826226cf1ddf2fbb274f049cab456a5c162efe3d648f0871564fadcf812
MININIX_PKG_SRCURL=https://github.com/zyedidia/micro/releases/download/v${MININIX_PKG_VERSION}/micro-${MININIX_PKG_VERSION}-src.tar.gz

mininix_step_make() {
	return
}

mininix_step_make_install() {
	mininix_setup_golang

	export GOPATH=$MININIX_PKG_BUILDDIR
	local MICRO_SRC=$GOPATH/src/github.com/zyedidia/micro

	cd $MININIX_PKG_SRCDIR
	mkdir -p $MICRO_SRC
	cp -R . $MICRO_SRC

	cd $MICRO_SRC
	make build-quick
	mv micro $MININIX_PREFIX/bin/micro
}
