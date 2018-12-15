MININIX_PKG_HOMEPAGE=https://strace.io/
MININIX_PKG_DESCRIPTION="Debugging utility to monitor system calls and signals received"
MININIX_PKG_VERSION=4.25
MININIX_PKG_SHA256=d685f8e65470b7832c3aff60c57ab4459f26ff89f07c10f92bd70ee89efac701
MININIX_PKG_SRCURL=https://github.com/strace/strace/releases/download/v$MININIX_PKG_VERSION/strace-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_RM_AFTER_INSTALL=bin/strace-graph # This is a perl script
# Without st_cv_m32_mpers=no the build fails if gawk is installed.
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
st_cv_m32_mpers=no
--enable-mpers=no
--without-libdw
"
