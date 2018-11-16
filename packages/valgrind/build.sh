LINUXDROID_PKG_HOMEPAGE=http://valgrind.org/
LINUXDROID_PKG_DESCRIPTION="Instrumentation framework for building dynamic analysis tools"
LINUXDROID_PKG_VERSION=3.14.0
LINUXDROID_PKG_SHA256=037c11bfefd477cc6e9ebe8f193bb237fe397f7ce791b4a4ce3fa1c6a520baa5
LINUXDROID_PKG_SRCURL=ftp://sourceware.org/pub/valgrind/valgrind-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-tmpdir=$LINUXDROID_PREFIX/tmp"
# - Does not build on x86_64 due to lacking upstream support of that arch on android.
#   https://bugs.kde.org/show_bug.cgi?id=348342
# - Does not build on aarch64 using clang, fails with
#   "`__builtin_longjmp is not supported for the current target"
#   https://bugs.kde.org/show_bug.cgi?id=369723
LINUXDROID_PKG_BLACKLISTED_ARCHES="x86_64"

linuxdroid_step_pre_configure() {
	if [ "$LINUXDROID_ARCH" == "aarch64" ]; then
		cp $LINUXDROID_PKG_BUILDER_DIR/aarch64-setjmp.S $LINUXDROID_PKG_SRCDIR
		autoreconf -if
	fi
	if [ "$LINUXDROID_ARCH" == "arm" ]; then
		# valgrind doesn't like arm; armv7 works, though.
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --host=armv7-linux-androideabi"
		# http://lists.busybox.net/pipermail/buildroot/2013-November/082270.html:
		# "valgrind uses inline assembly that is not Thumb compatible":
		CFLAGS=${CFLAGS/-mthumb/}
	fi
	if [ "$LINUXDROID_DEBUG" == "true" ]; then
		CFLAGS=${CFLAGS/-fstack-protector/}
	fi
}
