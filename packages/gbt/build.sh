LINUXDROID_PKG_HOMEPAGE=https://github.com/jtyr/gbt
LINUXDROID_PKG_DESCRIPTION="Highly configurable prompt builder for Bash and ZSH written in Go"
LINUXDROID_PKG_VERSION=1.2.0
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://github.com/jtyr/gbt/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=eb309bb93e01ee168a528fb0ed3a4920a702a9dad5a8f205642717086b9162a0

linuxdroid_step_make_install() {
	cd $LINUXDROID_PKG_SRCDIR

	linuxdroid_setup_golang

	export GOPATH=$HOME/go
	mkdir -p $GOPATH/{bin,pkg,src/github.com/jtyr}
	ln -fs $LINUXDROID_PKG_SRCDIR $GOPATH/src/github.com/jtyr/gbt

	go build -ldflags='-s -w' -o $LINUXDROID_PREFIX/bin/gbt github.com/jtyr/gbt/cmd/gbt

	mkdir -p $LINUXDROID_PREFIX/{doc/gbt,share/gbt}
	cp -r $LINUXDROID_PKG_SRCDIR/{sources,themes} $LINUXDROID_PREFIX/share/gbt/
	cp -r $LINUXDROID_PKG_SRCDIR/{LICENSE,README.md} $LINUXDROID_PREFIX/doc/gbt/
}
