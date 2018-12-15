MININIX_PKG_HOMEPAGE=http://tsocks.sf.net
MININIX_PKG_DESCRIPTION="transparent network access through a SOCKS 4 or 5 proxy"
MININIX_PKG_VERSION=1.8beta5
MININIX_PKG_REVISION=2
MININIX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/tsocks/tsocks/1.8%20beta%205/tsocks-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=849d7ef5af80d03e76cc05ed9fb8fa2bcc2b724b51ebfd1b6be11c7863f5b347
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS=" --with-conf=$MININIX_PREFIX/etc/tsocks.conf"

mininix_step_post_extract_package() {
	cp $MININIX_PKG_SRCDIR/tsocks-1.8/* $MININIX_PKG_SRCDIR/
}

mininix_step_pre_configure() {
	cp $MININIX_PKG_SRCDIR/tsocks.conf.complex.example $MININIX_PREFIX/etc/tsocks.conf
}
