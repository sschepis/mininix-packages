MININIX_PKG_HOMEPAGE=http://software.clapper.org/daemonize/
MININIX_PKG_DESCRIPTION="Run a command as a Unix daemon"
MININIX_PKG_VERSION=1.7.8
MININIX_PKG_SHA256=20c4fc9925371d1ddf1b57947f8fb93e2036eb9ccc3b43a1e3678ea8471c4c60
MININIX_PKG_SRCURL=https://github.com/bmc/daemonize/archive/release-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes"
