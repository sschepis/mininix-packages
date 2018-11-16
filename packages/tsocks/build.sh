LINUXDROID_PKG_HOMEPAGE=http://tsocks.sf.net
LINUXDROID_PKG_DESCRIPTION="transparent network access through a SOCKS 4 or 5 proxy"
LINUXDROID_PKG_VERSION=1.8beta5
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/project/tsocks/tsocks/1.8%20beta%205/tsocks-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=849d7ef5af80d03e76cc05ed9fb8fa2bcc2b724b51ebfd1b6be11c7863f5b347
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS=" --with-conf=$LINUXDROID_PREFIX/etc/tsocks.conf"

linuxdroid_step_post_extract_package() {
	cp $LINUXDROID_PKG_SRCDIR/tsocks-1.8/* $LINUXDROID_PKG_SRCDIR/
}

linuxdroid_step_pre_configure() {
	cp $LINUXDROID_PKG_SRCDIR/tsocks.conf.complex.example $LINUXDROID_PREFIX/etc/tsocks.conf
}
