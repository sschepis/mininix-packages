LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gzip/
LINUXDROID_PKG_DESCRIPTION="Standard GNU file compression utilities"
LINUXDROID_PKG_VERSION=1.9
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SHA256=ae506144fc198bd8f81f1f4ad19ce63d5a2d65e42333255977cf1dcf1479089a
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gzip/gzip-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_GREP=grep"

linuxdroid_step_pre_configure() {
	if [ $LINUXDROID_ARCH = i686 ]; then
		# Avoid text relocations
		export DEFS="NO_ASM"
	fi
}
