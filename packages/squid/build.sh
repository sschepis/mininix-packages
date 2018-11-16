LINUXDROID_PKG_HOMEPAGE=http://www.squid-cache.org
LINUXDROID_PKG_DESCRIPTION="Full-featured Web proxy cache server"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_VERSION=4.4
LINUXDROID_PKG_SHA256=4905e6da7f5574d2583ba36f398bb062a12d51e70d67035078b6e85b09e9ee82
LINUXDROID_PKG_SRCURL=http://www.squid-cache.org/Versions/v4/squid-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_DEPENDS="libcrypt, openssl, libnettle, libltdl"
# disk-io requires msgctl and store-io requires disk-io
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_sasl2_sasl_errstring=no
ac_cv_dbopen_libdb=no
squid_cv_gnu_atomics=yes
--disable-external-acl-helpers
--disable-strict-error-checking
--disable-disk-io
--disable-esi
--disable-storeio
--without-mit-krb5
--with-dl
--with-openssl
--disable-forw-via-db
--enable-auth
--without-libnettle
--enable-translation
--with-size-optimizations
--without-libxml2
--without-gnutls
--enable-delay-pools
--libexecdir=$LINUXDROID_PREFIX/libexec/squid
--sysconfdir=$LINUXDROID_PREFIX/etc/squid
--datarootdir=$LINUXDROID_PREFIX/share/squid
--mandir=$LINUXDROID_PREFIX/share/man
"

linuxdroid_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog"

	# needed for building cf_gen
	export BUILDCXX=g++
	# else it picks up our cross CXXFLAGS
	export BUILDCXXFLAGS=' '
}

