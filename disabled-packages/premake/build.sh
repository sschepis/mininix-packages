MININIX_PKG_HOMEPAGE=http://premake.github.io/
MININIX_PKG_DESCRIPTION="Build script generator"
MININIX_PKG_VERSION=4.4-beta5
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/premake/Premake/4.4/premake-${MININIX_PKG_VERSION}-src.zip
# MININIX_PKG_DEPENDS="pcre, openssl, libuuid"
# MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=openssl"


mininix_step_pre_configure () {
	MININIX_PKG_BUILDDIR=$MININIX_PKG_SRCDIR/build/gmake.unix
}
