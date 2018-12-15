MININIX_PKG_HOMEPAGE=https://rada.re
MININIX_PKG_DESCRIPTION="Advanced Hexadecimal Editor"
MININIX_PKG_VERSION=3.1.0
MININIX_PKG_SHA256=b6e74f29cc36ff25400376726e1315b37fe5876a1c82cf7bf75b39e6e5bbe41f
MININIX_PKG_SRCURL=https://github.com/radare/radare2/archive/$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libuv"
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-compiler=mininix-host"

mininix_step_pre_configure() {
	# Unset CPPFLAGS to avoid -I$MININIX_PREFIX/include. This is because
	# radare2 build will put it's own -I flags after ours, which causes
	# problems due to name clashes (binutils header files).
	unset CPPFLAGS

	# If this variable is not set, then build will fail on linking with 'pthread'
	export ANDROID=1

	export OBJCOPY=$MININIX_HOST_PLATFORM-objcopy

	# Remove old libs which may mess with new build:
	rm -f $MININIX_PREFIX/lib/libr_*
}
