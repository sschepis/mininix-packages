MININIX_PKG_HOMEPAGE=https://ipfs.io/
MININIX_PKG_DESCRIPTION="A peer-to-peer hypermedia distribution protocol"
MININIX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
MININIX_PKG_VERSION=0.4.18
MININIX_PKG_SHA256=bc03def6ac902d99ae29c60819dad2133af776d3f6779c55781afccaa89cec84
MININIX_PKG_SRCURL=https://github.com/ipfs/go-ipfs/archive/v${MININIX_PKG_VERSION}.tar.gz

mininix_step_make() {
    mininix_setup_golang

    export GOPATH=${MININIX_PKG_BUILDDIR}
    export GOARCH=${MININIX_ARCH}

    if [ "${MININIX_ARCH}" = "aarch64" ]; then
        export GOARCH="arm64"
    elif [ "${MININIX_ARCH}" = "i686" ]; then
        export GOARCH="386"
    elif [ "${MININIX_ARCH}" = "x86_64" ]; then
        export GOARCH="amd64"
    fi

    mkdir -p "${GOPATH}/src/github.com/ipfs"
    cp -a "${MININIX_PKG_SRCDIR}" "${GOPATH}/src/github.com/ipfs/go-ipfs"
    cd "${GOPATH}/src/github.com/ipfs/go-ipfs"

    make build
}

mininix_step_make_install() {
    mkdir -p "${MININIX_PREFIX}/bin"
    cp -f "${MININIX_PKG_BUILDDIR}/src/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs" "${MININIX_PREFIX}/bin/"
}
