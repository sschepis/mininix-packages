MININIX_PKG_HOMEPAGE=https://keybase.io
MININIX_PKG_DESCRIPTION="keybase"
MININIX_PKG_VERSION=2.10.1
MININIX_PKG_SHA256=8800fd7d247a94220842d426bb0ad703f0f413758c52ed911dbda27e833040bc
MININIX_PKG_SRCURL=https://github.com/keybase/client/archive/v${MININIX_PKG_VERSION}.tar.gz

mininix_step_make_install() {
	cd $MININIX_PKG_SRCDIR

	mininix_setup_golang

	mkdir -p .gopath/src/github.com/keybase
	ln -sf "$PWD" .gopath/src/github.com/keybase/client
	export GOPATH="$PWD/.gopath"

	go build -v -tags 'production' -o keybase github.com/keybase/client/go/keybase

	cp keybase $MININIX_PREFIX/bin/keybase
}
