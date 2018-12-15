MININIX_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Util-linux
MININIX_PKG_DESCRIPTION="Miscellaneous system utilities"
MININIX_PKG_VERSION=2.33
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=f261b9d73c35bfeeea04d26941ac47ee1df937bd3b0583e748217c1ea423658a
MININIX_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/util-linux/v${MININIX_PKG_VERSION:0:4}/util-linux-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="ncurses, libutil, libcrypt"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_setns=yes
ac_cv_func_unshare=yes
--disable-agetty
--disable-eject
--disable-ipcrm
--disable-ipcs
--disable-kill
--disable-last
--disable-libuuid
--disable-logger
--disable-pivot_root
--disable-switch_root
--disable-wall
--disable-libmount
--disable-lsmem
--disable-chmem
--disable-rfkill
"

mininix_step_pre_configure() {
	if [ $MININIX_ARCH_BITS = 64 ]; then
		# prlimit() is only available in 64-bit bionic.
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_prlimit=yes"
	fi
}
