LINUXDROID_PKG_HOMEPAGE=https://rada.re
LINUXDROID_PKG_DESCRIPTION="Advanced Hexadecimal Editor"
LINUXDROID_PKG_VERSION=3.0.1
LINUXDROID_PKG_SHA256=2de7c54f723b8439f899a86cb9e5142e7b62664994cea60aefdd9c2a69a3f9fe
LINUXDROID_PKG_SRCURL=https://github.com/radare/radare2/archive/$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libuv"
LINUXDROID_PKG_BUILD_IN_SRC="yes"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-compiler=linuxdroid-host"

linuxdroid_step_pre_configure() {
	# Unset CPPFLAGS to avoid -I$LINUXDROID_PREFIX/include. This is because
	# radare2 build will put it's own -I flags after ours, which causes
	# problems due to name clashes (binutils header files).
	unset CPPFLAGS

	# If this variable is not set, then build will fail on linking with 'pthread'
	export ANDROID=1

	export OBJCOPY=$LINUXDROID_HOST_PLATFORM-objcopy

	# Remove old libs which may mess with new build:
	rm -f $LINUXDROID_PREFIX/lib/libr_*
}
