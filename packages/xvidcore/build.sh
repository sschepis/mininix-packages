MININIX_PKG_HOMEPAGE=http://www.xvid.org/
MININIX_PKG_DESCRIPTION="High performance and high quality MPEG-4 library"
MININIX_PKG_VERSION=1.3.5
MININIX_PKG_SHA256=165ba6a2a447a8375f7b06db5a3c91810181f2898166e7c8137401d7fc894cf0
MININIX_PKG_SRCURL=http://downloads.xvid.org/downloads/xvidcore-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	rm -f $MININIX_PREFIX/lib/libxvid*
	export MININIX_PKG_BUILDDIR=$MININIX_PKG_BUILDDIR/build/generic
	export MININIX_PKG_SRCDIR=$MININIX_PKG_BUILDDIR

	if [ $MININIX_ARCH = i686 ]; then
		# Avoid text relocations:
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-assembly"
	fi
}

