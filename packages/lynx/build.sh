MININIX_PKG_HOMEPAGE=http://lynx.browser.org/
MININIX_PKG_DESCRIPTION="The text web browser"
MININIX_PKG_VERSION=2.8.9rel.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=387f193d7792f9cfada14c60b0e5c0bff18f227d9257a39483e14fa1aaf79595
MININIX_PKG_SRCURL=http://invisible-mirror.net/archives/lynx/tarballs/lynx${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="ncurses, openssl, libbz2, libidn"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-screen=ncursesw --enable-widec --enable-scrollbar --enable-nested-tables --enable-htmlized-cfg --with-ssl --with-zlib --with-bzlib --enable-cjk --enable-japanese-utf8 --enable-progressbar --enable-prettysrc --enable-forms-options --enable-8bit-toupper --enable-ascii-ctypes --disable-font-switch"

## set default paths for tools that may be used in runtime by 'lynx' binary
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_BZIP2=${MININIX_PREFIX}/bin/bzip2"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_COMPRESS=${MININIX_PREFIX}/bin/compress"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_GZIP=${MININIX_PREFIX}/bin/gzip"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_INSTALL=${MININIX_PREFIX}/bin/install"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MSGINIT=${MININIX_PREFIX}/bin/msginit"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MV=${MININIX_PREFIX}/bin/mv"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_RM=${MININIX_PREFIX}/bin/rm"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TAR=${MININIX_PREFIX}/bin/tar"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TELNET=${MININIX_PREFIX}/bin/applets/telnet"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNCOMPRESS=${MININIX_PREFIX}/bin/uncompress"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNZIP=${MININIX_PREFIX}/bin/unzip"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UUDECODE=${MININIX_PREFIX}/bin/uudecode"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZCAT=${MININIX_PREFIX}/bin/zcat"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZIP=${MININIX_PREFIX}/bin/zip"

mininix_step_pre_configure() {
	CC+=" $LDFLAGS"
	unset LDFLAGS
}

mininix_step_make_install () {
	make uninstall
	make install
}
