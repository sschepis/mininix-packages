LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/sed/
LINUXDROID_PKG_DESCRIPTION="GNU stream editor for filtering/transforming text"
LINUXDROID_PKG_VERSION=4.5
LINUXDROID_PKG_SHA256=7aad73c8839c2bdadca9476f884d2953cdace9567ecd0d90f9959f229d146b40
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/sed/sed-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_configure () {
	touch -d "next hour" $LINUXDROID_PKG_SRCDIR/doc/sed.1
}
