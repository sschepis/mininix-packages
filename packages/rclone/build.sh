LINUXDROID_PKG_HOMEPAGE=https://rclone.org/
LINUXDROID_PKG_DESCRIPTION="rsync for cloud storage"
LINUXDROID_PKG_VERSION=1.44
LINUXDROID_PKG_SHA256=2de5801f57d1e44da11b162c82cbe11cbcf8b9dac117beeb0d5207085d3497e0
LINUXDROID_PKG_SRCURL=https://github.com/ncw/rclone/releases/download/v${LINUXDROID_PKG_VERSION}/rclone-v${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_make_install() {
	cd $LINUXDROID_PKG_SRCDIR

	linuxdroid_setup_golang

	mkdir -p .gopath/src/github.com/ncw
	ln -sf "$PWD" .gopath/src/github.com/ncw/rclone
	export GOPATH="$PWD/.gopath"

	go build -v -o rclone

	# XXX: Fix read-only files which prevents removal of src dir.
	chmod u+w -R .

	cp rclone $LINUXDROID_PREFIX/bin/rclone
	mkdir -p $LINUXDROID_PREFIX/share/man/man1/
	cp rclone.1 $LINUXDROID_PREFIX/share/man/man1/
}
