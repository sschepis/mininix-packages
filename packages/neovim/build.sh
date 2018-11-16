LINUXDROID_PKG_HOMEPAGE=https://neovim.io/
LINUXDROID_PKG_DESCRIPTION="Ambitious Vim-fork focused on extensibility and agility (nvim)"
LINUXDROID_PKG_VERSION=0.3.1
LINUXDROID_PKG_SHA256=bc5e392d4c076407906ccecbc283e1a44b7832c2f486cad81aa04cc29973ad22
LINUXDROID_PKG_SRCURL=https://github.com/neovim/neovim/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libuv, libmsgpack, libandroid-support, libvterm, libtermkey, libutil, liblua, libunibilium"
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_JEMALLOC=OFF
-DGETTEXT_MSGFMT_EXECUTABLE=`which msgfmt`
-DGETTEXT_MSGMERGE_EXECUTABLE=`which msgmerge`
-DGPERF_PRG=$LINUXDROID_PKG_HOSTBUILD_DIR/deps/usr/bin/gperf
-DLUA_PRG=$LINUXDROID_PKG_HOSTBUILD_DIR/deps/usr/bin/luajit
-DPKG_CONFIG_EXECUTABLE=`which pkg-config`
-DXGETTEXT_PRG=`which xgettext`
-DPREFER_LUA=ON
-DLUA_INCLUDE_DIR=$LINUXDROID_PREFIX/include
"
LINUXDROID_PKG_CONFFILES="share/nvim/sysinit.vim"

linuxdroid_step_host_build () {
	linuxdroid_setup_cmake

	mkdir -p $LINUXDROID_PKG_HOSTBUILD_DIR/deps
	cd $LINUXDROID_PKG_HOSTBUILD_DIR/deps
	cmake $LINUXDROID_PKG_SRCDIR/third-party
	make -j 1

	cd $LINUXDROID_PKG_SRCDIR
	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$LINUXDROID_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install
	make distclean
	rm -Rf build/
}

linuxdroid_step_post_make_install () {
	local _CONFIG_DIR=$LINUXDROID_PREFIX/share/nvim
	mkdir -p $_CONFIG_DIR
	cp $LINUXDROID_PKG_BUILDER_DIR/sysinit.vim $_CONFIG_DIR/
}
