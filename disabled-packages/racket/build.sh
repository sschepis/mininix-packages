MININIX_PKG_HOMEPAGE=https://racket-lang.org
MININIX_PKG_DESCRIPTION="Full-spectrum programming language going beyond Lisp and Scheme"
MININIX_PKG_VERSION=6.12
MININIX_PKG_SRCURL=https://mirror.racket-lang.org/installers/${MININIX_PKG_VERSION}/racket-minimal-${MININIX_PKG_VERSION}-src-builtpkgs.tgz

MININIX_PKG_SHA256=295a422d60af2a3186a18783d033c167eeed07b936c79f404d25123a0209d683
MININIX_PKG_NO_DEVELSPLIT=true
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_DEPENDS="libffi, libandroid-support"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--enable-racket=$MININIX_PKG_HOSTBUILD_DIR/racket/racketcgc --enable-libs --disable-shared --disable-gracket --enable-libffi"

mininix_step_host_build () {
	$MININIX_PKG_SRCDIR/src/configure ${MININIX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j $MININIX_MAKE_PROCESSES
}

mininix_step_pre_configure () {
	CPPFLAGS+=" -I$MININIX_PKG_SRCDIR/src/racket/include -I$MININIX_PKG_BUILDDIR/racket"
	# Due to use of syslog.
	LDFLAGS+=" -llog"
	export MININIX_PKG_SRCDIR=$MININIX_PKG_SRCDIR/src
}
