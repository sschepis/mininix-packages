MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/bc/
MININIX_PKG_DESCRIPTION="Arbitrary precision numeric processing language"
MININIX_PKG_VERSION=1.07.1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/bc/bc-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a
MININIX_PKG_DEPENDS="readline,flex"
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--infodir=$MININIX_PREFIX/share/info
--mandir=$MININIX_PREFIX/share/man
--with-readline
"

mininix_step_pre_configure() {
	cp $MININIX_PKG_HOSTBUILD_DIR/bc/libmath.h \
	   $MININIX_PKG_SRCDIR/bc/libmath.h
	touch -d "next hour" $MININIX_PKG_SRCDIR/bc/libmath.h
}
