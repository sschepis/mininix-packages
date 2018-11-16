LINUXDROID_PKG_HOMEPAGE=https://core.tcl.tk/expect/index
LINUXDROID_PKG_DESCRIPTION="Tool for automating interactive terminal applications"
LINUXDROID_PKG_VERSION=5.45.4
LINUXDROID_PKG_SHA256=49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/expect/Expect/${LINUXDROID_PKG_VERSION}/expect${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libutil, tcl"

linuxdroid_step_pre_configure () {
	autoconf
}

linuxdroid_step_post_make_install () {
	cd $LINUXDROID_PREFIX/lib
	ln -f -s expect${LINUXDROID_PKG_VERSION}/libexpect${LINUXDROID_PKG_VERSION}.so .
}
