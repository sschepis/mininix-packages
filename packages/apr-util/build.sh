MININIX_PKG_HOMEPAGE=https://apr.apache.org/
MININIX_PKG_DESCRIPTION="Apache Portable Runtime Utility Library"
MININIX_PKG_VERSION=1.6.1
MININIX_PKG_SHA256=d3e12f7b6ad12687572a3a39475545a072608f4ba03a6ce8a3778f607dd0035b
MININIX_PKG_SRCURL=http://apache.mirrors.spacedump.net/apr/apr-util-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="apr, libexpat"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pq_PQsendQueryPrepared=no
--with-apr=$MININIX_PREFIX
--without-sqlite3
"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/apu-1-config"
MININIX_PKG_RM_AFTER_INSTALL="lib/aprutil.exp"
