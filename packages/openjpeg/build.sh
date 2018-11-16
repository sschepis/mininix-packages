LINUXDROID_PKG_HOMEPAGE=http://www.openjpeg.org/
LINUXDROID_PKG_DESCRIPTION="JPEG 2000 image compression library"
LINUXDROID_PKG_VERSION=2.3.0
LINUXDROID_PKG_SHA256=3dc787c1bb6023ba846c2a0d9b1f6e179f1cd255172bde9eb75b01f1e6c7d71a
LINUXDROID_PKG_SRCURL=https://github.com/uclouvain/openjpeg/archive/v${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_pre_configure () {
	# Force symlinks to be overwritten:
	rm -Rf $LINUXDROID_PREFIX/lib/libopenjp2.so*
}
