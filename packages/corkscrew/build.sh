MININIX_PKG_HOMEPAGE=http://wiki.linuxquestions.org/wiki/Corkscrew
MININIX_PKG_DESCRIPTION="A tool for tunneling SSH through HTTP proxies"
MININIX_PKG_DEPENDS="openssh"
MININIX_PKG_VERSION=2.0
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://dl.bintray.com/mininix/upstream/corkscrew-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=0d0fcbb41cba4a81c4ab494459472086f377f9edb78a2e2238ed19b58956b0be

mininix_step_post_make_install () {
	# Corkscrew does not distribute a man page, use one from debian:
	mkdir -p $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_BUILDER_DIR/corkscrew.1 $MININIX_PREFIX/share/man/man1
}
