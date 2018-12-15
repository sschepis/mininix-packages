MININIX_PKG_HOMEPAGE=https://core.tcl.tk/expect/index
MININIX_PKG_DESCRIPTION="Tool for automating interactive terminal applications"
MININIX_PKG_VERSION=5.45.4
MININIX_PKG_SHA256=49a7da83b0bdd9f46d04a04deec19c7767bb9a323e40c4781f89caf760b92c34
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/expect/Expect/${MININIX_PKG_VERSION}/expect${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libutil, tcl"

mininix_step_pre_configure () {
	autoconf
}

mininix_step_post_make_install () {
	cd $MININIX_PREFIX/lib
	ln -f -s expect${MININIX_PKG_VERSION}/libexpect${MININIX_PKG_VERSION}.so .
}
