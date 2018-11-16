LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/texinfo/
LINUXDROID_PKG_DESCRIPTION="Documentation system for on-line information and printed output"
LINUXDROID_PKG_VERSION=6.5
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=77774b3f4a06c20705cc2ef1c804864422e3cf95235e965b1f00a46df7da5f62
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/texinfo/texinfo-${LINUXDROID_PKG_VERSION}.tar.xz
# gawk is used by texindex:
LINUXDROID_PKG_DEPENDS="ncurses, perl, gawk"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-perl-xs"
