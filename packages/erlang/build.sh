LINUXDROID_PKG_HOMEPAGE=https://www.erlang.org/
LINUXDROID_PKG_DESCRIPTION="General-purpose concurrent functional programming language"
LINUXDROID_PKG_VERSION=21.1.1
LINUXDROID_PKG_SHA256=a6588243e9659960e184083f49b15ea37890e4cd9bb8aef84ba4180db68befc3
LINUXDROID_PKG_SRCURL=https://github.com/erlang/otp/archive/OTP-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="openssl, ncurses, libutil"
LINUXDROID_PKG_HOSTBUILD="yes"
LINUXDROID_PKG_BUILD_IN_SRC="yes"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--without-javac --with-ssl=${LINUXDROID_PREFIX} --with-termcap"
LINUXDROID_PKG_EXTRA_MAKE_ARGS="noboot"
LINUXDROID_PKG_KEEP_STATIC_LIBRARIES="true"
LINUXDROID_PKG_NO_DEVELSPLIT="yes"

linuxdroid_step_post_extract_package() {
	# We need a host build every time:
	rm -Rf "$LINUXDROID_PKG_HOSTBUILD_DIR"
	./otp_build autoconf
}

linuxdroid_step_host_build () {
	cd $LINUXDROID_PKG_SRCDIR
	./configure --enable-bootstrap-only
	make -j "$LINUXDROID_MAKE_PROCESSES"
}

linuxdroid_step_pre_configure () {
	(cd erts && autoreconf)

	# liblog is needed for syslog usage:
	LDFLAGS+=" -llog"
	# Put binaries built in linuxdroid_step_host_build at start of PATH:
	cp bin/*/* $LINUXDROID_PKG_SRCDIR/bootstrap/bin
	export PATH="$LINUXDROID_PKG_SRCDIR/bootstrap/bin:$PATH"
}
