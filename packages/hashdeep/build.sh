MININIX_PKG_HOMEPAGE=http://md5deep.sourceforge.net/
MININIX_PKG_DESCRIPTION="Programs to compute hashsums of arbitrary number of files recursively"
MININIX_PKG_VERSION=4.4
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://github.com/jessek/hashdeep/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=ad78d42142f9a74fe8ec0c61bc78d6588a528cbb9aede9440f50b6ff477f3a7f
if [ "$MININIX_ARCH_BITS" = 32 ]; then
	# hashdeep requires 64-bit off_t.
	MININIX_PKG_API_LEVEL=24
fi

mininix_step_pre_configure () {
	sh bootstrap.sh
	CPPFLAGS+=" -DMININIX_EXPOSE_FILE_OFFSET64=1"
}
