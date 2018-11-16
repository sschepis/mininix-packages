LINUXDROID_PKG_HOMEPAGE=http://www.xvid.org/
LINUXDROID_PKG_DESCRIPTION="High performance and high quality MPEG-4 library"
LINUXDROID_PKG_VERSION=1.3.5
LINUXDROID_PKG_SHA256=165ba6a2a447a8375f7b06db5a3c91810181f2898166e7c8137401d7fc894cf0
LINUXDROID_PKG_SRCURL=http://downloads.xvid.org/downloads/xvidcore-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	rm -f $LINUXDROID_PREFIX/lib/libxvid*
	export LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_BUILDDIR/build/generic
	export LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_BUILDDIR

	if [ $LINUXDROID_ARCH = i686 ]; then
		# Avoid text relocations:
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-assembly"
	fi
}

