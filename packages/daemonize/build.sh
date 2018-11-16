LINUXDROID_PKG_HOMEPAGE=http://software.clapper.org/daemonize/
LINUXDROID_PKG_DESCRIPTION="Run a command as a Unix daemon"
LINUXDROID_PKG_VERSION=1.7.8
LINUXDROID_PKG_SHA256=20c4fc9925371d1ddf1b57947f8fb93e2036eb9ccc3b43a1e3678ea8471c4c60
LINUXDROID_PKG_SRCURL=https://github.com/bmc/daemonize/archive/release-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes"
