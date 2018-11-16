# NOTE: Currently segfaults when running.
LINUXDROID_PKG_HOMEPAGE=http://checkinstall.izto.org/
LINUXDROID_PKG_DESCRIPTION="Installation tracker creating a package from a local install"
LINUXDROID_PKG_VERSION=1.6.2
LINUXDROID_PKG_SRCURL=http://checkinstall.izto.org/files/source/checkinstall-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="file, make"
LINUXDROID_PKG_RM_AFTER_INSTALL="lib/checkinstall/locale/"

linuxdroid_step_pre_configure() {
	CFLAGS+=" -D__off64_t=off64_t"
	CFLAGS+=" -D_STAT_VER=3"
	CFLAGS+=" -D_MKNOD_VER=1"
	CFLAGS+=" -DS_IREAD=S_IRUSR"
}

linuxdroid_step_post_make_install () {
	mv $LINUXDROID_PREFIX/lib/checkinstall/checkinstallrc-dist \
	   $LINUXDROID_PREFIX/lib/checkinstall/checkinstallrc
}
