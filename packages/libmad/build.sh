LINUXDROID_PKG_HOMEPAGE=http://www.underbit.com/products/mad/
LINUXDROID_PKG_DESCRIPTION="MAD is a high-quality MPEG audio decoder"
LINUXDROID_PKG_VERSION=0.15.1b
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=ftp://ftp.mars.org/pub/mpeg/libmad-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=bbfac3ed6bfbc2823d3775ebb931087371e142bb0e9bb1bee51a76a6e0078690

linuxdroid_step_pre_configure() {
	if [ $LINUXDROID_ARCH = arm ]; then
		# See https://www.mars.org/pipermail/mad-dev/2013-July/001433.html
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-fpm=default"
	fi
}

linuxdroid_post_configure() {
	cd $LINUXDROID_PKG_SRCDIR
	sed -i -e 's/-force-mem//g' Makefile
}
