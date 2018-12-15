MININIX_PKG_HOMEPAGE=https://syncthing.net/
MININIX_PKG_DESCRIPTION="Decentralized file synchronization"
MININIX_PKG_VERSION=0.14.52
MININIX_PKG_SHA256=4954c2b05c60b6de29104d4783193a51164485cfa4a810c5a0696d72a83816c2
MININIX_PKG_SRCURL=https://github.com/syncthing/syncthing/releases/download/v${MININIX_PKG_VERSION}/syncthing-source-v${MININIX_PKG_VERSION}.tar.gz

mininix_step_make(){
	mininix_setup_golang

	# The build.sh script doesn't with our compiler
	# so small adjustments to file locations are needed
	# so the build.go is fine.
	mkdir -p go/src/github.com/syncthing/syncthing
	cp $MININIX_PKG_SRCDIR/vendor/* ./go/src/ -r
	cp $MININIX_PKG_SRCDIR/*  go/src/github.com/syncthing/syncthing -r

	# Set gopath so dependencies are built as in go get etc.
	export GOPATH=$(pwd)/go

	cd go/src/github.com/syncthing/syncthing

	# Unset GOARCH so building build.go is works.
	export GO_ARCH=$GOARCH
	export _CC=$CC
	unset GOOS GOARCH CC
	
	# Now file structure is same as go get etc.
	go build build.go
	export CC=$_CC
	./build -goos android \
		-goarch $GO_ARCH \
		-no-upgrade \
		-version v$MININIX_PKG_VERSION \
		build
}

mininix_step_make_install() {
	cp go/src/github.com/syncthing/syncthing/syncthing $MININIX_PREFIX/bin/

	for section in 1 5 7; do
		local MANDIR=$PREFIX/share/man/man$section
		mkdir -p $MANDIR
		cp $MININIX_PKG_SRCDIR/man/*.$section $MANDIR
	done
}
