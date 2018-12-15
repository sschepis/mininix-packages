MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/sed/
MININIX_PKG_DESCRIPTION="GNU stream editor for filtering/transforming text"
MININIX_PKG_VERSION=4.5
MININIX_PKG_SHA256=7aad73c8839c2bdadca9476f884d2953cdace9567ecd0d90f9959f229d146b40
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/sed/sed-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_configure () {
	touch -d "next hour" $MININIX_PKG_SRCDIR/doc/sed.1
}
