MININIX_PKG_HOMEPAGE=https://neovim.io/
MININIX_PKG_DESCRIPTION="Ambitious Vim-fork focused on extensibility and agility (nvim)"
MININIX_PKG_VERSION=0.3.1
MININIX_PKG_SHA256=bc5e392d4c076407906ccecbc283e1a44b7832c2f486cad81aa04cc29973ad22
MININIX_PKG_SRCURL=https://github.com/neovim/neovim/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libuv, libmsgpack, libandroid-support, libvterm, libtermkey, libutil, liblua, libunibilium"
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_JEMALLOC=OFF
-DGETTEXT_MSGFMT_EXECUTABLE=`which msgfmt`
-DGETTEXT_MSGMERGE_EXECUTABLE=`which msgmerge`
-DGPERF_PRG=$MININIX_PKG_HOSTBUILD_DIR/deps/usr/bin/gperf
-DLUA_PRG=$MININIX_PKG_HOSTBUILD_DIR/deps/usr/bin/luajit
-DPKG_CONFIG_EXECUTABLE=`which pkg-config`
-DXGETTEXT_PRG=`which xgettext`
-DPREFER_LUA=ON
-DLUA_INCLUDE_DIR=$MININIX_PREFIX/include
"
MININIX_PKG_CONFFILES="share/nvim/sysinit.vim"

mininix_step_host_build () {
	mininix_setup_cmake

	mkdir -p $MININIX_PKG_HOSTBUILD_DIR/deps
	cd $MININIX_PKG_HOSTBUILD_DIR/deps
	cmake $MININIX_PKG_SRCDIR/third-party
	make -j 1

	cd $MININIX_PKG_SRCDIR
	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$MININIX_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install
	make distclean
	rm -Rf build/
}

mininix_step_post_make_install () {
	local _CONFIG_DIR=$MININIX_PREFIX/share/nvim
	mkdir -p $_CONFIG_DIR
	cp $MININIX_PKG_BUILDER_DIR/sysinit.vim $_CONFIG_DIR/
}
