LINUXDROID_PKG_HOMEPAGE=https://bitbucket.org/wez/atomicparsley
LINUXDROID_PKG_DESCRIPTION="Read, parse and set metadata of MPEG-4 and 3gp files"
LINUXDROID_PKG_VERSION=0.9.6
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://bitbucket.org/wez/atomicparsley/get/${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=e28d46728be86219e6ce48695ea637d831ca0170ca6bdac99810996a8291ee50
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_lroundf=yes"

linuxdroid_step_pre_configure() {
	./autogen.sh

	# Avoid the configure script from using g++ for linking:
	export OBJCXX=$CXX
}
