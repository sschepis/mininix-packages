LINUXDROID_PKG_HOMEPAGE=http://sourceforge.net/projects/wake-on-lan/
LINUXDROID_PKG_DESCRIPTION="Program implementing Wake On LAN functionality"
LINUXDROID_PKG_VERSION=0.7.1
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/project/wake-on-lan/wol/${LINUXDROID_PKG_VERSION}/wol-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$LINUXDROID_PREFIX/share/man"
LINUXDROID_PKG_RM_AFTER_INSTALL="info/"

linuxdroid_step_pre_configure() {
	export ac_cv_func_mmap_fixed_mapped=yes
	export jm_cv_func_working_malloc=yes
	export ac_cv_func_alloca_works=yes
}
