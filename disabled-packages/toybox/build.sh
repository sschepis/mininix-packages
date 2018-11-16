LINUXDROID_PKG_HOMEPAGE=http://landley.net/toybox/
LINUXDROID_PKG_DESCRIPTION="Common Linux command line utilities"
LINUXDROID_PKG_VERSION=0.7.3
LINUXDROID_PKG_SRCURL=http://landley.net/toybox/downloads/toybox-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=e6469b508224e0d2e4564dda05c4bb47aef5c28bf29d6c983bcdc6e3a0cd29d6
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure () {
	make defconfig
}
