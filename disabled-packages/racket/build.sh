LINUXDROID_PKG_HOMEPAGE=https://racket-lang.org
LINUXDROID_PKG_DESCRIPTION="Full-spectrum programming language going beyond Lisp and Scheme"
LINUXDROID_PKG_VERSION=6.12
LINUXDROID_PKG_SRCURL=https://mirror.racket-lang.org/installers/${LINUXDROID_PKG_VERSION}/racket-minimal-${LINUXDROID_PKG_VERSION}-src-builtpkgs.tgz

LINUXDROID_PKG_SHA256=295a422d60af2a3186a18783d033c167eeed07b936c79f404d25123a0209d683
LINUXDROID_PKG_NO_DEVELSPLIT=true
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_DEPENDS="libffi, libandroid-support"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--enable-racket=$LINUXDROID_PKG_HOSTBUILD_DIR/racket/racketcgc --enable-libs --disable-shared --disable-gracket --enable-libffi"

linuxdroid_step_host_build () {
	$LINUXDROID_PKG_SRCDIR/src/configure ${LINUXDROID_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j $LINUXDROID_MAKE_PROCESSES
}

linuxdroid_step_pre_configure () {
	CPPFLAGS+=" -I$LINUXDROID_PKG_SRCDIR/src/racket/include -I$LINUXDROID_PKG_BUILDDIR/racket"
	# Due to use of syslog.
	LDFLAGS+=" -llog"
	export LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_SRCDIR/src
}
