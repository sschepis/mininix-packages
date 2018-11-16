LINUXDROID_PKG_HOMEPAGE=http://lynx.browser.org/
LINUXDROID_PKG_DESCRIPTION="The text web browser"
LINUXDROID_PKG_VERSION=2.8.9rel.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=387f193d7792f9cfada14c60b0e5c0bff18f227d9257a39483e14fa1aaf79595
LINUXDROID_PKG_SRCURL=http://invisible-mirror.net/archives/lynx/tarballs/lynx${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="ncurses, openssl, libbz2, libidn"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-screen=ncursesw --enable-widec --enable-scrollbar --enable-nested-tables --enable-htmlized-cfg --with-ssl --with-zlib --with-bzlib --enable-cjk --enable-japanese-utf8 --enable-progressbar --enable-prettysrc --enable-forms-options --enable-8bit-toupper --enable-ascii-ctypes --disable-font-switch"

## set default paths for tools that may be used in runtime by 'lynx' binary
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_BZIP2=${LINUXDROID_PREFIX}/bin/bzip2"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_COMPRESS=${LINUXDROID_PREFIX}/bin/compress"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_GZIP=${LINUXDROID_PREFIX}/bin/gzip"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_INSTALL=${LINUXDROID_PREFIX}/bin/install"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MSGINIT=${LINUXDROID_PREFIX}/bin/msginit"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MV=${LINUXDROID_PREFIX}/bin/mv"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_RM=${LINUXDROID_PREFIX}/bin/rm"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TAR=${LINUXDROID_PREFIX}/bin/tar"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TELNET=${LINUXDROID_PREFIX}/bin/applets/telnet"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNCOMPRESS=${LINUXDROID_PREFIX}/bin/uncompress"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNZIP=${LINUXDROID_PREFIX}/bin/unzip"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UUDECODE=${LINUXDROID_PREFIX}/bin/uudecode"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZCAT=${LINUXDROID_PREFIX}/bin/zcat"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZIP=${LINUXDROID_PREFIX}/bin/zip"

linuxdroid_step_pre_configure() {
	CC+=" $LDFLAGS"
	unset LDFLAGS
}

linuxdroid_step_make_install () {
	make uninstall
	make install
}
