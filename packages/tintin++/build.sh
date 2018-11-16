LINUXDROID_PKG_HOMEPAGE=http://tintin.sourceforge.net
LINUXDROID_PKG_DESCRIPTION="Classic text-based MUD client"
LINUXDROID_PKG_VERSION=2.01.4
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=dd22afbff45a93ec399065bae385489131af7e1b6ae8abb28f80d6a03b82ebbc
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/project/tintin/TinTin%2B%2B%20Source%20Code/${LINUXDROID_PKG_VERSION}/tintin-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_file__dev_ptmx=no"
LINUXDROID_PKG_DEPENDS="pcre, libgnutls, libutil"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_extract_package() {
	LINUXDROID_PKG_SRCDIR+="/src"
	LINUXDROID_PKG_BUILDDIR="$LINUXDROID_PKG_SRCDIR"
}

linuxdroid_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}
