MININIX_PKG_HOMEPAGE=http://x265.org/
MININIX_PKG_DESCRIPTION="H.265/HEVC video stream encoder library"
MININIX_PKG_VERSION=2.9
MININIX_PKG_SHA256=ebae687c84a39f54b995417c52a2fdde65a4e2e7ebac5730d251471304b91024
MININIX_PKG_SRCURL=http://ftp.videolan.org/pub/videolan/x265/x265_${MININIX_PKG_VERSION}.tar.gz

mininix_step_pre_configure () {
	if [ $MININIX_ARCH = "i686" ]; then
		# Avoid text relocations.
		MININIX_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_ASSEMBLY=OFF"
	fi
	MININIX_PKG_SRCDIR="$MININIX_PKG_SRCDIR/source"
}

