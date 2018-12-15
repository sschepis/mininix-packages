MININIX_PKG_HOMEPAGE=https://www.nongnu.org/cvs/
MININIX_PKG_DESCRIPTION="Concurrent Versions System"
MININIX_PKG_VERSION="1.12.13+real-26"
MININIX_PKG_SHA256=0eda91f5e8091b676c90b2a171f24f9293acb552f4e4f77b590ae8d92a547256
MININIX_PKG_SRCURL="https://dl.bintray.com/mininix/upstream/cvs-$MININIX_PKG_VERSION.tar.xz"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
cvs_cv_func_printf_ptr=yes
ac_cv_header_syslog_h=no
--disable-server
--with-external-zlib
"
MININIX_PKG_RM_AFTER_INSTALL="bin/cvsbug share/man/man8/cvsbug.8"
