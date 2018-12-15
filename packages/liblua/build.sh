MININIX_PKG_HOMEPAGE=https://www.lua.org/
MININIX_PKG_DESCRIPTION="Shared library for the Lua interpreter"
MININIX_PKG_VERSION=5.3.5
MININIX_PKG_SHA256=0c2eed3f960446e1a3e4b9a1ca2f3ff893b6ce41942cf54d5dd59ab4b3b058ac
MININIX_PKG_SRCURL=https://www.lua.org/ftp/lua-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_MAKE_ARGS=linux
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_CONFLICTS=libluajit
MININIX_PKG_REPLACES=libluajit
MININIX_PKG_BUILD_DEPENDS="readline"

mininix_step_pre_configure () {
	AR+=" rcu"
	CFLAGS+=" -fPIC -DLUA_COMPAT_5_2 -DLUA_COMPAT_UNPACK"
}

mininix_step_post_make_install() {
	# Add a pkg-config file for the system zlib
	cat > "$PKG_CONFIG_LIBDIR/lua.pc" <<-HERE
		Name: Lua
		Description: An Extensible Extension Language
		Version: $MININIX_PKG_VERSION
		Requires:
		Libs: -llua -lm
	HERE
}
