MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/global/
MININIX_PKG_DESCRIPTION="Source code search and browse tools"
MININIX_PKG_VERSION=6.6.2
MININIX_PKG_SHA256=43c64711301c2caf40dc56d7b91dd03d2b882a31fa31812bf20de0c8fb2e717f
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/global/global-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_posix1_2008_realpath=yes
--with-posix-sort=$MININIX_PREFIX/bin/sort
--with-ncurses=$MININIX_PREFIX
"
# coreutils provides the posix sort executable:
MININIX_PKG_DEPENDS="coreutils, ncurses, libltdl"
