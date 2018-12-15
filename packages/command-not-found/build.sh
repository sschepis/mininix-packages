MININIX_PKG_HOMEPAGE=https://mininix.com
MININIX_PKG_DESCRIPTION="Suggest installation of packages in interactive shell sessions"
MININIX_PKG_VERSION=1.36

mininix_step_make_install () {
	MININIX_LIBEXEC_DIR=$MININIX_PREFIX/libexec/mininix
	mkdir -p $MININIX_LIBEXEC_DIR
	$CC -Wall -Wextra -Werror -pedantic $CFLAGS $LDFLAGS -std=c11 $MININIX_PKG_BUILDER_DIR/command-not-found.c \
	        -o $MININIX_LIBEXEC_DIR/command-not-found
}
