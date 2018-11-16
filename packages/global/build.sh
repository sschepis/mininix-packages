LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/global/
LINUXDROID_PKG_DESCRIPTION="Source code search and browse tools"
LINUXDROID_PKG_VERSION=6.6.2
LINUXDROID_PKG_SHA256=43c64711301c2caf40dc56d7b91dd03d2b882a31fa31812bf20de0c8fb2e717f
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/global/global-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_posix1_2008_realpath=yes
--with-posix-sort=$LINUXDROID_PREFIX/bin/sort
--with-ncurses=$LINUXDROID_PREFIX
"
# coreutils provides the posix sort executable:
LINUXDROID_PKG_DEPENDS="coreutils, ncurses, libltdl"
