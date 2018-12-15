MININIX_PKG_HOMEPAGE=https://www.cyrusimap.org/sasl/
MININIX_PKG_DESCRIPTION="Cyrus SASL - authentication abstraction library"
MININIX_PKG_VERSION=2.1.26
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://cyrusimap.org/releases/cyrus-sasl-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=8fbc5136512b59bb793657f36fadda6359cae3b08f01fd16b3d406f1345b7bc3
# Seems to be race issues in build (symlink creation)::
MININIX_MAKE_PROCESSES=1
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_syslog=no
ac_cv_header_syslog_h=no
--disable-gssapi
--disable-otp
--sysconfdir=$MININIX_PREFIX/etc
--with-dblib=none
--with-dbpath=$MININIX_PREFIX/var/lib/sasldb
--without-des
--without-saslauthd
--with-plugindir=$MININIX_PREFIX/lib/sasl2
"
MININIX_PKG_RM_AFTER_INSTALL="bin/pluginviewer"

mininix_step_post_configure () {
	# Build wants to run makemd5 at build time:
	gcc $MININIX_PKG_SRCDIR/include/makemd5.c -o $MININIX_PKG_BUILDDIR/include/makemd5
	touch -d "next hour" $MININIX_PKG_BUILDDIR/include/makemd5
}

mininix_step_post_massage () {
	for sub in anonymous crammd5 digestmd5 plain; do
		local base=lib/sasl2/lib${sub}
		if [ ! -L ${base}.so ] || [ ! -L ${base}.so.3 ] || [ ! -f ${base}.so.3.0.0 ] ; then
			mininix_error_exit "libsasl not packaged with $base"
		fi
	done
}
