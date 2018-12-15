MININIX_PKG_HOMEPAGE=http://gondor.apana.org.au/~herbert/dash/
MININIX_PKG_DESCRIPTION="Small POSIX-compliant implementation of /bin/sh"
MININIX_PKG_ESSENTIAL=yes
MININIX_PKG_VERSION=0.5.10.2
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=3c663919dc5c66ec991da14c7cf7e0be8ad00f3db73986a987c118862b5f6071
MININIX_PKG_SRCURL=http://gondor.apana.org.au/~herbert/dash/files/dash-${MININIX_PKG_VERSION}.tar.gz

mininix_step_post_make_install () {
	# Symlink sh -> dash
	rm -f $MININIX_PREFIX/bin/sh $MININIX_PREFIX/share/man/man1/sh.1
	cd $MININIX_PREFIX/bin
	ln -s dash sh
	cd $MININIX_PREFIX/share/man/man1
	ln -s dash.1 sh.1
}
