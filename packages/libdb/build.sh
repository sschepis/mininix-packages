MININIX_PKG_HOMEPAGE=https://www.oracle.com/database/berkeley-db
MININIX_PKG_DESCRIPTION="The Berkeley DB embedded database system (library)"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_VERSION=6.2.32
MININIX_PKG_SRCURL=http://download.oracle.com/berkeley-db/db-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=a9c5e2b004a5777aa03510cfe5cd766a4a3b777713406b02809c17c8e0e7a8fb
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hash
--enable-smallbuild
--enable-compat185
db_cv_atomic=gcc-builtin
"
MININIX_PKG_RM_AFTER_INSTALL="docs"

mininix_step_pre_configure() {
	MININIX_PKG_SRCDIR=$MININIX_PKG_SRCDIR/dist
}
