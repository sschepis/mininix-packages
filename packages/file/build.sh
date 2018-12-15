MININIX_PKG_HOMEPAGE=https://darwinsys.com/file/
MININIX_PKG_DESCRIPTION="Command-line tool that tells you in words what kind of data a file contains"
MININIX_PKG_VERSION=5.35
MININIX_PKG_SHA256=30c45e817440779be7aac523a905b123cba2a6ed0bf4f5439e1e99ba940b5546
MININIX_PKG_SRCURL=ftp://ftp.astron.com/pub/file/file-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_mmap_fixed_mapped=yes"
MININIX_PKG_EXTRA_MAKE_ARGS="FILE_COMPILE=$MININIX_PKG_HOSTBUILD_DIR/src/file"
MININIX_PKG_HOSTBUILD="yes"
