MININIX_PKG_HOMEPAGE=http://www.squid-cache.org
MININIX_PKG_DESCRIPTION="Full-featured Web proxy cache server"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_VERSION=4.4
MININIX_PKG_SHA256=4905e6da7f5574d2583ba36f398bb062a12d51e70d67035078b6e85b09e9ee82
MININIX_PKG_SRCURL=http://www.squid-cache.org/Versions/v4/squid-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_DEPENDS="libcrypt, openssl, libnettle, libltdl"
# disk-io requires msgctl and store-io requires disk-io
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
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
--libexecdir=$MININIX_PREFIX/libexec/squid
--sysconfdir=$MININIX_PREFIX/etc/squid
--datarootdir=$MININIX_PREFIX/share/squid
--mandir=$MININIX_PREFIX/share/man
"

mininix_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog"

	# needed for building cf_gen
	export BUILDCXX=g++
	# else it picks up our cross CXXFLAGS
	export BUILDCXXFLAGS=' '
}

