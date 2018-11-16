LINUXDROID_PKG_HOMEPAGE=https://linuxdroid.app
LINUXDROID_PKG_DESCRIPTION="Suggest installation of packages in interactive shell sessions"
LINUXDROID_PKG_VERSION=1.35

linuxdroid_step_make_install () {
	LINUXDROID_LIBEXEC_DIR=$LINUXDROID_PREFIX/libexec/linuxdroid
	mkdir -p $LINUXDROID_LIBEXEC_DIR
	$CC -Wall -Wextra -Werror -pedantic $CFLAGS $LDFLAGS -std=c11 $LINUXDROID_PKG_BUILDER_DIR/command-not-found.c \
	        -o $LINUXDROID_LIBEXEC_DIR/command-not-found
}
