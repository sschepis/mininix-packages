MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/tar/
MININIX_PKG_DESCRIPTION="GNU tar for manipulating tar archives"
MININIX_PKG_VERSION=1.30
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/tar/tar-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=f1bf92dbb1e1ab27911a861ea8dde8208ee774866c46c0bb6ead41f4d1f4d2d3
# Allow xz compression (busybox only provides xz decompression):
MININIX_PKG_DEPENDS="xz-utils"
# When cross-compiling configure guesses that d_ino in struct dirent only exists
# if triplet matches linux*-gnu*, so we force set it explicitly:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="gl_cv_struct_dirent_d_ino=yes"

# this needed to disable tar's implementation of mkfifoat() so it is possible
# to use own implementation (see patch 'mkfifoat.patch').
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_mkfifoat=yes"
