LINUXDROID_PKG_HOMEPAGE=https://ocaml.org
LINUXDROID_PKG_DESCRIPTION="Programming language supporting functional, imperative and object-oriented styles"
LINUXDROID_PKG_VERSION=4.02.3
LINUXDROID_PKG_SRCURL=http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.3.tar.xz
LINUXDROID_PKG_DEPENDS="pcre, openssl, libuuid"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure () {
	./configure -prefix $LINUXDROID_PREFIX -mandir $LINUXDROID_PREFIX/share/man/man1 -cc "$CC $CFLAGS $CPPFLAGS $LDFLAGS" \
		-host $LINUXDROID_HOST_PLATFORM
}
