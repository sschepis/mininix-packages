LINUXDROID_PKG_HOMEPAGE=http://wiki.linuxquestions.org/wiki/Corkscrew
LINUXDROID_PKG_DESCRIPTION="A tool for tunneling SSH through HTTP proxies"
LINUXDROID_PKG_DEPENDS="openssh"
LINUXDROID_PKG_VERSION=2.0
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://dl.bintray.com/linuxdroid/upstream/corkscrew-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=0d0fcbb41cba4a81c4ab494459472086f377f9edb78a2e2238ed19b58956b0be

linuxdroid_step_post_make_install () {
	# Corkscrew does not distribute a man page, use one from debian:
	mkdir -p $LINUXDROID_PREFIX/share/man/man1
	cp $LINUXDROID_PKG_BUILDER_DIR/corkscrew.1 $LINUXDROID_PREFIX/share/man/man1
}
