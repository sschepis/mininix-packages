MININIX_PKG_HOMEPAGE=https://bitbucket.org/wez/atomicparsley
MININIX_PKG_DESCRIPTION="Read, parse and set metadata of MPEG-4 and 3gp files"
MININIX_PKG_VERSION=0.9.6
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://bitbucket.org/wez/atomicparsley/get/${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_SHA256=e28d46728be86219e6ce48695ea637d831ca0170ca6bdac99810996a8291ee50
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_lroundf=yes"

mininix_step_pre_configure() {
	./autogen.sh

	# Avoid the configure script from using g++ for linking:
	export OBJCXX=$CXX
}
