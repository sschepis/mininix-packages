MININIX_PKG_HOMEPAGE=https://hub.github.com/
MININIX_PKG_DESCRIPTION="Command-line wrapper for git that makes you better at GitHub"
MININIX_PKG_VERSION=2.6.0
MININIX_PKG_SHA256=c4df5ce953aa5dd5c4fa57ada96559b4b76bbd30a9e961e10e881be869cf4f2c
MININIX_PKG_SRCURL=https://github.com/github/hub/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="git"

mininix_step_make_install() {
	mininix_setup_golang

	cd $MININIX_PKG_SRCDIR

	export GOPATH="${MININIX_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${MININIX_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"
	cd "${GOPATH}/src/github.com/github/hub"
	make bin/hub prefix=$MININIX_PREFIX
	cp ./bin/hub $MININIX_PREFIX/bin/hub
}
