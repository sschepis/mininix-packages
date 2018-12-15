MININIX_PKG_HOMEPAGE=http://www.fftw.org/
MININIX_PKG_DESCRIPTION="Library for computing the Discrete Fourier Transform (DFT) in one or more dimensions"
MININIX_PKG_VERSION=3.3.8
MININIX_PKG_SHA256=6113262f6e92c5bd474f2875fa1b01054c4ad5040f6b0da7c03c98821d9ae303
MININIX_PKG_SRCURL=http://www.fftw.org/fftw-${MININIX_PKG_VERSION}.tar.gz
# ac_cv_func_clock_gettime=no avoids having clock_gettime(CLOCK_SGI_CYCLE, &t)
# being used. It's not supported on Android but fails at runtime and, fftw
# does not check the return value so gets bogus values.
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--enable-threads ac_cv_func_clock_gettime=no"
MININIX_PKG_RM_AFTER_INSTALL="include/fftw*.f*"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/ share/man/"

mininix_step_post_make_install() {
	local COMMON_ARGS="$MININIX_PKG_EXTRA_CONFIGURE_ARGS"
	local feature
	for feature in float long-double; do
		make clean
		MININIX_PKG_EXTRA_CONFIGURE_ARGS="$COMMON_ARGS --enable-$feature"
		rm -Rf $MININIX_PKG_TMPDIR/config-scripts
		mininix_step_configure
		make -j $MININIX_MAKE_PROCESSES install
	done
}
