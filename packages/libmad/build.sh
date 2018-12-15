MININIX_PKG_HOMEPAGE=http://www.underbit.com/products/mad/
MININIX_PKG_DESCRIPTION="MAD is a high-quality MPEG audio decoder"
MININIX_PKG_VERSION=0.15.1b
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=ftp://ftp.mars.org/pub/mpeg/libmad-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=bbfac3ed6bfbc2823d3775ebb931087371e142bb0e9bb1bee51a76a6e0078690

mininix_step_pre_configure() {
	if [ $MININIX_ARCH = arm ]; then
		# See https://www.mars.org/pipermail/mad-dev/2013-July/001433.html
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-fpm=default"
	fi
}

mininix_post_configure() {
	cd $MININIX_PKG_SRCDIR
	sed -i -e 's/-force-mem//g' Makefile
}
