MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/gzip/
MININIX_PKG_DESCRIPTION="Standard GNU file compression utilities"
MININIX_PKG_VERSION=1.9
MININIX_PKG_REVISION=2
MININIX_PKG_SHA256=ae506144fc198bd8f81f1f4ad19ce63d5a2d65e42333255977cf1dcf1479089a
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gzip/gzip-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_GREP=grep"

mininix_step_pre_configure() {
	if [ $MININIX_ARCH = i686 ]; then
		# Avoid text relocations
		export DEFS="NO_ASM"
	fi
}
