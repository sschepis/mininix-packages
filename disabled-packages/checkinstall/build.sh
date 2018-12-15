# NOTE: Currently segfaults when running.
MININIX_PKG_HOMEPAGE=http://checkinstall.izto.org/
MININIX_PKG_DESCRIPTION="Installation tracker creating a package from a local install"
MININIX_PKG_VERSION=1.6.2
MININIX_PKG_SRCURL=http://checkinstall.izto.org/files/source/checkinstall-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="file, make"
MININIX_PKG_RM_AFTER_INSTALL="lib/checkinstall/locale/"

mininix_step_pre_configure() {
	CFLAGS+=" -D__off64_t=off64_t"
	CFLAGS+=" -D_STAT_VER=3"
	CFLAGS+=" -D_MKNOD_VER=1"
	CFLAGS+=" -DS_IREAD=S_IRUSR"
}

mininix_step_post_make_install () {
	mv $MININIX_PREFIX/lib/checkinstall/checkinstallrc-dist \
	   $MININIX_PREFIX/lib/checkinstall/checkinstallrc
}
