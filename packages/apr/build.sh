MININIX_PKG_HOMEPAGE=https://apr.apache.org/
MININIX_PKG_DESCRIPTION="Apache Portable Runtime Library"
MININIX_PKG_VERSION=1.6.5
MININIX_PKG_SHA256=a67ca9fcf9c4ff59bce7f428a323c8b5e18667fdea7b0ebad47d194371b0a105
MININIX_PKG_SRCURL=http://apache.mirrors.spacedump.net/apr/apr-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="libuuid"
MININIX_PKG_BUILD_IN_SRC="yes"
# "ac_cv_search_crypt=" to avoid needlessly linking to libcrypt.
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--with-installbuilddir=$MININIX_PREFIX/share/apr-1/build
ac_cv_file__dev_zero=yes
ac_cv_func_setpgrp_void=yes
apr_cv_process_shared_works=no
apr_cv_tcp_nodelay_with_cork=yes
ac_cv_sizeof_struct_iovec=$(( MININIX_ARCH_BITS==32 ? 8 : 16 ))
ac_cv_search_crypt="
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/apr-1-config share/apr-1/build"
MININIX_PKG_RM_AFTER_INSTALL="lib/apr.exp"
