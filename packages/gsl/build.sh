LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gsl/
LINUXDROID_PKG_DESCRIPTION="GNU Scientific Library (GSL) providing a wide range of mathematical routines"
LINUXDROID_PKG_VERSION=2.5
LINUXDROID_PKG_SHA256=0460ad7c2542caaddc6729762952d345374784100223995eb14d614861f2258d
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gsl/gsl-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/ share/man/man1"

# Workaround for linker on Android 5 (fixed in Android 6) not supporting RTLD_GLOBAL.
# See https://github.com/linuxdroid/linuxdroid-packages/issues/507
export GSL_LDFLAGS="-Lcblas/.libs/ -lgslcblas"
