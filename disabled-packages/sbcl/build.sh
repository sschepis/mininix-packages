LINUXDROID_PKG_HOMEPAGE=http://www.sbcl.org/
LINUXDROID_PKG_DESCRIPTION="Steel Bank Common Lisp"
LINUXDROID_PKG_VERSION=1.3.9
LINUXDROID_PKG_SRCURL=http://prdownloads.sourceforge.net/sbcl/sbcl-${LINUXDROID_PKG_VERSION}-source.tar.bz2

linuxdroid_step_pre_configure () {
	local SBCL_HOST_TARFILE=$LINUXDROID_PKG_CACHEDIR/sbcl-host-${LINUXDROID_PKG_VERSION}.tar.bz2
	if [ ! -f $SBCL_HOST_TARFILE ]; then
		curl -o $SBCL_HOST_TARFILE -L http://downloads.sourceforge.net/project/sbcl/sbcl/${LINUXDROID_PKG_VERSION}/sbcl-${LINUXDROID_PKG_VERSION}-x86-64-linux-binary.tar.bz2
		cd $LINUXDROID_PKG_TMPDIR
		tar xf $SBCL_HOST_TARFILE
		cd sbcl-${LINUXDROID_PKG_VERSION}-x86-64-linux
		INSTALL_ROOT=$LINUXDROID_PKG_CACHEDIR/sbcl-host sh install.sh
	fi
	export PATH=$PATH:$LINUXDROID_PKG_CACHEDIR/sbcl-host/bin
	export SBCL_HOME=$LINUXDROID_PKG_CACHEDIR/sbcl-host/lib/sbcl
}

linuxdroid_step_make_install () {
	cd $LINUXDROID_PKG_SRCDIR
	sh make.sh --prefix=$LINUXDROID_PREFIX
}
