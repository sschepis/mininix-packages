MININIX_PKG_HOMEPAGE=http://mama.indstate.edu/users/ice/tree/
MININIX_PKG_DESCRIPTION="Recursive directory lister producing a depth indented listing of files"
MININIX_PKG_MAINTAINER="Gert Scholten @gscholt"
MININIX_PKG_VERSION=1.8.0
MININIX_PKG_SHA256=715d5d4b434321ce74706d0dd067505bb60c5ea83b5f0b3655dae40aa6f9b7c2
MININIX_PKG_SRCURL=http://mama.indstate.edu/users/ice/tree/src/tree-${MININIX_PKG_VERSION}.tgz
MININIX_PKG_DEPENDS="libandroid-support"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make () {
	make \
		CC="$CC" \
		CFLAGS="$CFLAGS $CPPFLAGS -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64" \
		LDFLAGS="$LDFLAGS" \
		OBJS="file.o tree.o unix.o html.o xml.o json.o hash.o color.o strverscmp.o"
}

mininix_step_make_install () {
	make install \
		prefix="$MININIX_PREFIX" \
		MANDIR="$MININIX_PREFIX/share/man/man1"
}
