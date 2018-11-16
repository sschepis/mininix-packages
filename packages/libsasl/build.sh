LINUXDROID_PKG_HOMEPAGE=https://www.cyrusimap.org/sasl/
LINUXDROID_PKG_DESCRIPTION="Cyrus SASL - authentication abstraction library"
LINUXDROID_PKG_VERSION=2.1.26
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://cyrusimap.org/releases/cyrus-sasl-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=8fbc5136512b59bb793657f36fadda6359cae3b08f01fd16b3d406f1345b7bc3
# Seems to be race issues in build (symlink creation)::
LINUXDROID_MAKE_PROCESSES=1
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_syslog=no
ac_cv_header_syslog_h=no
--disable-gssapi
--disable-otp
--sysconfdir=$LINUXDROID_PREFIX/etc
--with-dblib=none
--with-dbpath=$LINUXDROID_PREFIX/var/lib/sasldb
--without-des
--without-saslauthd
--with-plugindir=$LINUXDROID_PREFIX/lib/sasl2
"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/pluginviewer"

linuxdroid_step_post_configure () {
	# Build wants to run makemd5 at build time:
	gcc $LINUXDROID_PKG_SRCDIR/include/makemd5.c -o $LINUXDROID_PKG_BUILDDIR/include/makemd5
	touch -d "next hour" $LINUXDROID_PKG_BUILDDIR/include/makemd5
}

linuxdroid_step_post_massage () {
	for sub in anonymous crammd5 digestmd5 plain; do
		local base=lib/sasl2/lib${sub}
		if [ ! -L ${base}.so ] || [ ! -L ${base}.so.3 ] || [ ! -f ${base}.so.3.0.0 ] ; then
			linuxdroid_error_exit "libsasl not packaged with $base"
		fi
	done
}
