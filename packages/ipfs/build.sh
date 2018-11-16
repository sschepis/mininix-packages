LINUXDROID_PKG_HOMEPAGE=https://ipfs.io/
LINUXDROID_PKG_DESCRIPTION="A peer-to-peer hypermedia distribution protocol"
LINUXDROID_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
LINUXDROID_PKG_VERSION=0.4.18
LINUXDROID_PKG_SHA256=bc03def6ac902d99ae29c60819dad2133af776d3f6779c55781afccaa89cec84
LINUXDROID_PKG_SRCURL=https://github.com/ipfs/go-ipfs/archive/v${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_make() {
    linuxdroid_setup_golang

    export GOPATH=${LINUXDROID_PKG_BUILDDIR}
    export GOARCH=${LINUXDROID_ARCH}

    if [ "${LINUXDROID_ARCH}" = "aarch64" ]; then
        export GOARCH="arm64"
    elif [ "${LINUXDROID_ARCH}" = "i686" ]; then
        export GOARCH="386"
    elif [ "${LINUXDROID_ARCH}" = "x86_64" ]; then
        export GOARCH="amd64"
    fi

    mkdir -p "${GOPATH}/src/github.com/ipfs"
    cp -a "${LINUXDROID_PKG_SRCDIR}" "${GOPATH}/src/github.com/ipfs/go-ipfs"
    cd "${GOPATH}/src/github.com/ipfs/go-ipfs"

    make build
}

linuxdroid_step_make_install() {
    mkdir -p "${LINUXDROID_PREFIX}/bin"
    cp -f "${LINUXDROID_PKG_BUILDDIR}/src/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs" "${LINUXDROID_PREFIX}/bin/"
}
