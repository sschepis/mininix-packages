MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/texinfo/
MININIX_PKG_DESCRIPTION="Documentation system for on-line information and printed output"
MININIX_PKG_VERSION=6.5
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=77774b3f4a06c20705cc2ef1c804864422e3cf95235e965b1f00a46df7da5f62
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/texinfo/texinfo-${MININIX_PKG_VERSION}.tar.xz
# gawk is used by texindex:
MININIX_PKG_DEPENDS="ncurses, perl, gawk"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-perl-xs"
