LINUXDROID_PKG_HOMEPAGE=https://libevent.org/
LINUXDROID_PKG_DESCRIPTION="Library that provides asynchronous event notification"
LINUXDROID_PKG_VERSION=2.1.8
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://github.com/libevent/libevent/archive/release-${LINUXDROID_PKG_VERSION}-stable.tar.gz
LINUXDROID_PKG_SHA256=316ddb401745ac5d222d7c529ef1eada12f58f6376a66c1118eee803cb70f83d
# Strip away libevent core, extra and openssl libraries until someone uses them
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/event_rpcgen.py lib/libevent_*"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DEVENT__BUILD_SHARED_LIBRARIES=ON
-DEVENT__DISABLE_BENCHMARK=ON
-DEVENT__DISABLE_OPENSSL=ON
-DEVENT__DISABLE_REGRESS=ON
-DEVENT__DISABLE_SAMPLES=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__DISABLE_TESTS=ON
-DEVENT__HAVE_WAITPID_WITH_WNOWAIT=ON
-DEVENT__SIZEOF_PTHREAD_T=$((LINUXDROID_ARCH_BITS/8))
"
linuxdroid_step_post_make_install() {
	# Building with cmake does not install .pc files, see
	# https://github.com/libevent/libevent/issues/443
	cat > "$PKG_CONFIG_LIBDIR/libevent.pc" <<-HERE
		Name: libevent
		Description: libevent is an asynchronous notification event loop library
		Version: ${LINUXDROID_PKG_VERSION}-stable
		Libs: -levent
	HERE
}
