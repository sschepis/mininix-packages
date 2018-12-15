MININIX_PKG_HOMEPAGE=http://www.sbcl.org/
MININIX_PKG_DESCRIPTION="Steel Bank Common Lisp"
MININIX_PKG_VERSION=1.3.9
MININIX_PKG_SRCURL=http://prdownloads.sourceforge.net/sbcl/sbcl-${MININIX_PKG_VERSION}-source.tar.bz2

mininix_step_pre_configure () {
	local SBCL_HOST_TARFILE=$MININIX_PKG_CACHEDIR/sbcl-host-${MININIX_PKG_VERSION}.tar.bz2
	if [ ! -f $SBCL_HOST_TARFILE ]; then
		curl -o $SBCL_HOST_TARFILE -L http://downloads.sourceforge.net/project/sbcl/sbcl/${MININIX_PKG_VERSION}/sbcl-${MININIX_PKG_VERSION}-x86-64-linux-binary.tar.bz2
		cd $MININIX_PKG_TMPDIR
		tar xf $SBCL_HOST_TARFILE
		cd sbcl-${MININIX_PKG_VERSION}-x86-64-linux
		INSTALL_ROOT=$MININIX_PKG_CACHEDIR/sbcl-host sh install.sh
	fi
	export PATH=$PATH:$MININIX_PKG_CACHEDIR/sbcl-host/bin
	export SBCL_HOME=$MININIX_PKG_CACHEDIR/sbcl-host/lib/sbcl
}

mininix_step_make_install () {
	cd $MININIX_PKG_SRCDIR
	sh make.sh --prefix=$MININIX_PREFIX
}
