MININIX_PKG_HOMEPAGE=http://tintin.sourceforge.net
MININIX_PKG_DESCRIPTION="Classic text-based MUD client"
MININIX_PKG_VERSION=2.01.4
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=dd22afbff45a93ec399065bae385489131af7e1b6ae8abb28f80d6a03b82ebbc
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/tintin/TinTin%2B%2B%20Source%20Code/${MININIX_PKG_VERSION}/tintin-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_file__dev_ptmx=no"
MININIX_PKG_DEPENDS="pcre, libgnutls, libutil"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_extract_package() {
	MININIX_PKG_SRCDIR+="/src"
	MININIX_PKG_BUILDDIR="$MININIX_PKG_SRCDIR"
}

mininix_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}
