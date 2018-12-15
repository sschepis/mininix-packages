MININIX_PKG_HOMEPAGE=http://www.nongnu.org/libunwind/
MININIX_PKG_DESCRIPTION="Library to determine the call-chain of a program"
# Use master and the commit date as version suffix:
local _COMMIT=2b8ab794b3a636c05396fdbaebbba25d8aa4722a
MININIX_PKG_VERSION=1.2.20170304
MININIX_PKG_SRCURL=https://github.com/libunwind/libunwind/archive/${_COMMIT}.zip
MININIX_PKG_SHA256=fdbe8f0348a0db86663fdf7a363fcb281fef220f85bd751db8ed13aca00c062d
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-tests
--disable-coredump
--disable-minidebuginfo
"

mininix_step_post_extract_package() {
	NOCONFIGURE=1 ./autogen.sh
}

mininix_step_post_massage() {
	# Hack to fix problem with building arm c++ code
	# which should not use this libunwind:
	rm $MININIX_PREFIX/lib/libunwind*
	rm $MININIX_PREFIX/include/{unwind.h,libunwind*.h}
}
