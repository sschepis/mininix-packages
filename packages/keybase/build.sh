LINUXDROID_PKG_HOMEPAGE=https://keybase.io
LINUXDROID_PKG_DESCRIPTION="keybase"
LINUXDROID_PKG_VERSION=2.8.0
LINUXDROID_PKG_SHA256=7123d041682ee7958c408b63d6d6ae488d0cc7994249cda5f35c8cf12b348400
LINUXDROID_PKG_SRCURL=https://github.com/keybase/client/archive/v${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_make_install() {
	cd $LINUXDROID_PKG_SRCDIR

	linuxdroid_setup_golang

	mkdir -p .gopath/src/github.com/keybase
	ln -sf "$PWD" .gopath/src/github.com/keybase/client
	export GOPATH="$PWD/.gopath"

	go build -v -tags 'production' -o keybase github.com/keybase/client/go/keybase

	cp keybase $LINUXDROID_PREFIX/bin/keybase
}
