MININIX_PKG_HOMEPAGE=https://rclone.org/
MININIX_PKG_DESCRIPTION="rsync for cloud storage"
MININIX_PKG_VERSION=1.45
MININIX_PKG_SHA256=a3041a54d4f1eb795faceca153741e4d5a3b44521ff99873c2070fa4d8c9769b
MININIX_PKG_SRCURL=https://github.com/ncw/rclone/releases/download/v${MININIX_PKG_VERSION}/rclone-v${MININIX_PKG_VERSION}.tar.gz

mininix_step_make_install() {
	cd $MININIX_PKG_SRCDIR

	mininix_setup_golang

	mkdir -p .gopath/src/github.com/ncw
	ln -sf "$PWD" .gopath/src/github.com/ncw/rclone
	export GOPATH="$PWD/.gopath"

	go build -v -o rclone

	# XXX: Fix read-only files which prevents removal of src dir.
	chmod u+w -R .

	cp rclone $MININIX_PREFIX/bin/rclone
	mkdir -p $MININIX_PREFIX/share/man/man1/
	cp rclone.1 $MININIX_PREFIX/share/man/man1/
}
