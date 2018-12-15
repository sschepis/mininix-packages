MININIX_PKG_HOMEPAGE=https://github.com/jtyr/gbt
MININIX_PKG_DESCRIPTION="Highly configurable prompt builder for Bash and ZSH written in Go"
MININIX_PKG_VERSION=1.2.0
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://github.com/jtyr/gbt/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=eb309bb93e01ee168a528fb0ed3a4920a702a9dad5a8f205642717086b9162a0

mininix_step_make_install() {
	cd $MININIX_PKG_SRCDIR

	mininix_setup_golang

	export GOPATH=$HOME/go
	mkdir -p $GOPATH/{bin,pkg,src/github.com/jtyr}
	ln -fs $MININIX_PKG_SRCDIR $GOPATH/src/github.com/jtyr/gbt

	go build -ldflags='-s -w' -o $MININIX_PREFIX/bin/gbt github.com/jtyr/gbt/cmd/gbt

	mkdir -p $MININIX_PREFIX/{doc/gbt,share/gbt}
	cp -r $MININIX_PKG_SRCDIR/{sources,themes} $MININIX_PREFIX/share/gbt/
	cp -r $MININIX_PKG_SRCDIR/{LICENSE,README.md} $MININIX_PREFIX/doc/gbt/
}
