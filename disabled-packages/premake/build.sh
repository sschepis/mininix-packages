LINUXDROID_PKG_HOMEPAGE=http://premake.github.io/
LINUXDROID_PKG_DESCRIPTION="Build script generator"
LINUXDROID_PKG_VERSION=4.4-beta5
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/premake/Premake/4.4/premake-${LINUXDROID_PKG_VERSION}-src.zip
# LINUXDROID_PKG_DEPENDS="pcre, openssl, libuuid"
# LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=openssl"


linuxdroid_step_pre_configure () {
	LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_SRCDIR/build/gmake.unix
}
