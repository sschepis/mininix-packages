LINUXDROID_PKG_HOMEPAGE=http://gondor.apana.org.au/~herbert/dash/
LINUXDROID_PKG_DESCRIPTION="Small POSIX-compliant implementation of /bin/sh"
LINUXDROID_PKG_ESSENTIAL=yes
LINUXDROID_PKG_VERSION=0.5.10.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=3c663919dc5c66ec991da14c7cf7e0be8ad00f3db73986a987c118862b5f6071
LINUXDROID_PKG_SRCURL=http://gondor.apana.org.au/~herbert/dash/files/dash-${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_post_make_install () {
	# Symlink sh -> dash
	rm -f $LINUXDROID_PREFIX/bin/sh $LINUXDROID_PREFIX/share/man/man1/sh.1
	cd $LINUXDROID_PREFIX/bin
	ln -s dash sh
	cd $LINUXDROID_PREFIX/share/man/man1
	ln -s dash.1 sh.1
}
