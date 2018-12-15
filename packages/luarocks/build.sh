MININIX_PKG_HOMEPAGE=https://luarocks.org/
MININIX_PKG_DESCRIPTION="Deployment and management system for Lua modules"
MININIX_PKG_VERSION=2.4.4
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=3938df33de33752ff2c526e604410af3dceb4b7ff06a770bc4a240de80a1f934
MININIX_PKG_SRCURL=https://luarocks.org/releases/luarocks-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="curl, lua"
MININIX_PKG_BUILD_DEPENDS="liblua-dev"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_configure () {
	./configure --prefix=$MININIX_PREFIX \
		--with-lua=$MININIX_PREFIX \
		--lua-version=5.3
}
