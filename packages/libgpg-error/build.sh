LINUXDROID_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libgpg-error/
LINUXDROID_PKG_DESCRIPTION="Small library that defines common error values for all GnuPG components"
LINUXDROID_PKG_VERSION=1.32
LINUXDROID_PKG_SHA256=c345c5e73cc2332f8d50db84a2280abfb1d8f6d4f1858b9daa30404db44540ca
LINUXDROID_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_RM_AFTER_INSTALL="share/common-lisp"

linuxdroid_step_post_extract_package () {
	# Upstream only has Android definitions for platform-specific lock objects.
	# See https://lists.gnupg.org/pipermail/gnupg-devel/2014-January/028203.html
	# for how to generate a lock-obj header file on devices.

	# For aarch64 this was generated on a device:
	cp $LINUXDROID_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h $LINUXDROID_PKG_SRCDIR/src/syscfg/

	if [ $LINUXDROID_ARCH = i686 ]; then
		# Android i686 has same config as arm (verified by generating a file on a i686 device):
		cp $LINUXDROID_PKG_SRCDIR/src/syscfg/lock-obj-pub.arm-unknown-linux-androideabi.h \
		   $LINUXDROID_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	elif [ $LINUXDROID_ARCH = x86_64 ]; then
		# FIXME: Generate on device.
		cp $LINUXDROID_PKG_BUILDER_DIR/lock-obj-pub.aarch64-unknown-linux-android.h \
			$LINUXDROID_PKG_SRCDIR/src/syscfg/lock-obj-pub.linux-android.h
	fi
}
