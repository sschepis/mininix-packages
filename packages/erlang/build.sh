MININIX_PKG_HOMEPAGE=https://www.erlang.org/
MININIX_PKG_DESCRIPTION="General-purpose concurrent functional programming language"
MININIX_PKG_VERSION=21.1.3
MININIX_PKG_SHA256=9a447e1debed355ff78f5d502dc8259139d5aed2362037e7cca9dc9919245eca
MININIX_PKG_SRCURL=https://github.com/erlang/otp/archive/OTP-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="openssl, ncurses, libutil"
MININIX_PKG_HOSTBUILD="yes"
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-javac --with-ssl=${MININIX_PREFIX} --with-termcap"
MININIX_PKG_EXTRA_MAKE_ARGS="noboot"
MININIX_PKG_KEEP_STATIC_LIBRARIES="true"
MININIX_PKG_NO_DEVELSPLIT="yes"

mininix_step_post_extract_package() {
	# We need a host build every time:
	rm -Rf "$MININIX_PKG_HOSTBUILD_DIR"
	./otp_build autoconf
}

mininix_step_host_build () {
	cd $MININIX_PKG_SRCDIR
	./configure --enable-bootstrap-only
	make -j "$MININIX_MAKE_PROCESSES"
}

mininix_step_pre_configure () {
	(cd erts && autoreconf)

	# liblog is needed for syslog usage:
	LDFLAGS+=" -llog"
	# Put binaries built in mininix_step_host_build at start of PATH:
	cp bin/*/* $MININIX_PKG_SRCDIR/bootstrap/bin
	export PATH="$MININIX_PKG_SRCDIR/bootstrap/bin:$PATH"
}
