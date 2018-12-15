MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/libiconv/
MININIX_PKG_DESCRIPTION="Utility converting between different character encodings"
MININIX_PKG_VERSION=1.15
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/libiconv/libiconv-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178
# Only install the binary, not the library since we use libandroid-support for iconv functions:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--enable-static --disable-shared"

mininix_step_make_install () {
	mkdir -p $MININIX_PREFIX/share/man/man1
	make -C lib install # this installs libiconv.{a,la} which the below install task needs:
	make -C src install
        rm $MININIX_PREFIX/lib/libiconv.{a,la}
        # .. and the man page:
        cp $MININIX_PKG_SRCDIR/man/iconv.1 $MININIX_PREFIX/share/man/man1/
}
