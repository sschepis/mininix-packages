MININIX_PKG_HOMEPAGE=http://sourceforge.net/projects/wake-on-lan/
MININIX_PKG_DESCRIPTION="Program implementing Wake On LAN functionality"
MININIX_PKG_VERSION=0.7.1
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/wake-on-lan/wol/${MININIX_PKG_VERSION}/wol-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MININIX_PREFIX/share/man"
MININIX_PKG_RM_AFTER_INSTALL="info/"

mininix_step_pre_configure() {
	export ac_cv_func_mmap_fixed_mapped=yes
	export jm_cv_func_working_malloc=yes
	export ac_cv_func_alloca_works=yes
}
