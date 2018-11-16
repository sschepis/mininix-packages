LINUXDROID_PKG_HOMEPAGE=https://www.oracle.com/database/berkeley-db
LINUXDROID_PKG_DESCRIPTION="The Berkeley DB embedded database system (library)"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_VERSION=6.2.32
LINUXDROID_PKG_SRCURL=http://download.oracle.com/berkeley-db/db-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=a9c5e2b004a5777aa03510cfe5cd766a4a3b777713406b02809c17c8e0e7a8fb
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--enable-hash
--enable-smallbuild
--enable-compat185
db_cv_atomic=gcc-builtin
"
LINUXDROID_PKG_RM_AFTER_INSTALL="docs"

linuxdroid_step_pre_configure() {
	LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_SRCDIR/dist
}
