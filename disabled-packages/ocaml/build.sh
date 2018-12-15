MININIX_PKG_HOMEPAGE=https://ocaml.org
MININIX_PKG_DESCRIPTION="Programming language supporting functional, imperative and object-oriented styles"
MININIX_PKG_VERSION=4.02.3
MININIX_PKG_SRCURL=http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.3.tar.xz
MININIX_PKG_DEPENDS="pcre, openssl, libuuid"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_configure () {
	./configure -prefix $MININIX_PREFIX -mandir $MININIX_PREFIX/share/man/man1 -cc "$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		-host $MININIX_HOST_PLATFORM
}
