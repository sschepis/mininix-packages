LINUXDROID_PKG_HOMEPAGE=https://hub.github.com/
LINUXDROID_PKG_DESCRIPTION="Command-line wrapper for git that makes you better at GitHub"
LINUXDROID_PKG_VERSION=2.6.0
LINUXDROID_PKG_SHA256=c4df5ce953aa5dd5c4fa57ada96559b4b76bbd30a9e961e10e881be869cf4f2c
LINUXDROID_PKG_SRCURL=https://github.com/github/hub/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="git"

linuxdroid_step_make_install() {
	linuxdroid_setup_golang

	cd $LINUXDROID_PKG_SRCDIR

	export GOPATH="${LINUXDROID_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/github"
	cp -a "${LINUXDROID_PKG_SRCDIR}" "${GOPATH}/src/github.com/github/hub"
	cd "${GOPATH}/src/github.com/github/hub"
	make bin/hub prefix=$LINUXDROID_PREFIX
	cp ./bin/hub $LINUXDROID_PREFIX/bin/hub
}
