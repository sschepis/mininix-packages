MININIX_PKG_HOMEPAGE=https://golang.org/
MININIX_PKG_DESCRIPTION="Go programming language compiler"
local _MAJOR_VERSION=1.11.2
MININIX_PKG_SHA256=042fba357210816160341f1002440550e952eb12678f7c9e7e9d389437942550
# Use the ~ deb versioning construct in the future:
MININIX_PKG_VERSION=2:${_MAJOR_VERSION}
MININIX_PKG_SRCURL=https://storage.googleapis.com/golang/go${_MAJOR_VERSION}.src.tar.gz
MININIX_PKG_KEEP_STATIC_LIBRARIES=true
MININIX_PKG_DEPENDS="clang"

mininix_step_make_install () {
	mininix_setup_golang

	MININIX_GOLANG_DIRNAME=${GOOS}_$GOARCH
	MININIX_GODIR=$MININIX_PREFIX/lib/go
	rm -Rf $MININIX_GODIR
	mkdir -p $MININIX_GODIR/{src,doc,lib,pkg/tool/$MININIX_GOLANG_DIRNAME,pkg/include,pkg/${MININIX_GOLANG_DIRNAME}}

	cd $MININIX_PKG_SRCDIR/src
	env CC_FOR_TARGET=$CC \
	    CXX_FOR_TARGET=$CXX \
	    CC=gcc \
	    GO_LDFLAGS="-extldflags=-pie" \
	    GOROOT_BOOTSTRAP=$GOROOT \
	    GOROOT_FINAL=$MININIX_GODIR \
	    ./make.bash

	cd ..
	cp bin/$MININIX_GOLANG_DIRNAME/{go,gofmt} $MININIX_PREFIX/bin
	cp VERSION $MININIX_GODIR/
	cp pkg/tool/$MININIX_GOLANG_DIRNAME/* $MININIX_GODIR/pkg/tool/$MININIX_GOLANG_DIRNAME/
	cp -Rf src/* $MININIX_GODIR/src/
	cp -Rf doc/* $MININIX_GODIR/doc/
	cp pkg/include/* $MININIX_GODIR/pkg/include/
	cp -Rf lib/* $MININIX_GODIR/lib
	cp -Rf pkg/${MININIX_GOLANG_DIRNAME}/* $MININIX_GODIR/pkg/${MININIX_GOLANG_DIRNAME}/
}

mininix_step_post_massage () {
	find . -path '*/testdata*' -delete
}
