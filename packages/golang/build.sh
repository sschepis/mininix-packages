LINUXDROID_PKG_HOMEPAGE=https://golang.org/
LINUXDROID_PKG_DESCRIPTION="Go programming language compiler"
local _MAJOR_VERSION=1.11.2
LINUXDROID_PKG_SHA256=042fba357210816160341f1002440550e952eb12678f7c9e7e9d389437942550
# Use the ~ deb versioning construct in the future:
LINUXDROID_PKG_VERSION=2:${_MAJOR_VERSION}
LINUXDROID_PKG_SRCURL=https://storage.googleapis.com/golang/go${_MAJOR_VERSION}.src.tar.gz
LINUXDROID_PKG_KEEP_STATIC_LIBRARIES=true
LINUXDROID_PKG_DEPENDS="clang"

linuxdroid_step_make_install () {
	linuxdroid_setup_golang

	LINUXDROID_GOLANG_DIRNAME=${GOOS}_$GOARCH
	LINUXDROID_GODIR=$LINUXDROID_PREFIX/lib/go
	rm -Rf $LINUXDROID_GODIR
	mkdir -p $LINUXDROID_GODIR/{src,doc,lib,pkg/tool/$LINUXDROID_GOLANG_DIRNAME,pkg/include,pkg/${LINUXDROID_GOLANG_DIRNAME}}

	cd $LINUXDROID_PKG_SRCDIR/src
	env CC_FOR_TARGET=$CC \
	    CXX_FOR_TARGET=$CXX \
	    CC=gcc \
	    GO_LDFLAGS="-extldflags=-pie" \
	    GOROOT_BOOTSTRAP=$GOROOT \
	    GOROOT_FINAL=$LINUXDROID_GODIR \
	    ./make.bash

	cd ..
	cp bin/$LINUXDROID_GOLANG_DIRNAME/{go,gofmt} $LINUXDROID_PREFIX/bin
	cp VERSION $LINUXDROID_GODIR/
	cp pkg/tool/$LINUXDROID_GOLANG_DIRNAME/* $LINUXDROID_GODIR/pkg/tool/$LINUXDROID_GOLANG_DIRNAME/
	cp -Rf src/* $LINUXDROID_GODIR/src/
	cp -Rf doc/* $LINUXDROID_GODIR/doc/
	cp pkg/include/* $LINUXDROID_GODIR/pkg/include/
	cp -Rf lib/* $LINUXDROID_GODIR/lib
	cp -Rf pkg/${LINUXDROID_GOLANG_DIRNAME}/* $LINUXDROID_GODIR/pkg/${LINUXDROID_GOLANG_DIRNAME}/
}

linuxdroid_step_post_massage () {
	find . -path '*/testdata*' -delete
}
