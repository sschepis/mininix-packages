LINUXDROID_PKG_HOMEPAGE=http://www.linuxfromscratch.org/blfs/view/svn/general/popt.html
LINUXDROID_PKG_DESCRIPTION="Library for parsing cmdline parameters"
LINUXDROID_PKG_VERSION=1.16
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/popt-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=e728ed296fe9f069a0e005003c3d6b2dde3d9cad453422a10d6558616d304cc8
LINUXDROID_PKG_DEPENDS="libandroid-glob"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}
