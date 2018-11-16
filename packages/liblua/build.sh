LINUXDROID_PKG_HOMEPAGE=https://www.lua.org/
LINUXDROID_PKG_DESCRIPTION="Shared library for the Lua interpreter"
LINUXDROID_PKG_VERSION=5.3.5
LINUXDROID_PKG_SHA256=0c2eed3f960446e1a3e4b9a1ca2f3ff893b6ce41942cf54d5dd59ab4b3b058ac
LINUXDROID_PKG_SRCURL=https://www.lua.org/ftp/lua-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_MAKE_ARGS=linux
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_CONFLICTS=libluajit
LINUXDROID_PKG_REPLACES=libluajit
LINUXDROID_PKG_BUILD_DEPENDS="readline"

linuxdroid_step_pre_configure () {
	AR+=" rcu"
	CFLAGS+=" -fPIC -DLUA_COMPAT_5_2 -DLUA_COMPAT_UNPACK"
}

linuxdroid_step_post_make_install() {
	# Add a pkg-config file for the system zlib
	cat > "$PKG_CONFIG_LIBDIR/lua.pc" <<-HERE
		Name: Lua
		Description: An Extensible Extension Language
		Version: $LINUXDROID_PKG_VERSION
		Requires:
		Libs: -llua -lm
	HERE
}
