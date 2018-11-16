LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/bc/
LINUXDROID_PKG_DESCRIPTION="Arbitrary precision numeric processing language"
LINUXDROID_PKG_VERSION=1.07.1
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/bc/bc-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc46daf9931cf4942664cb02a
LINUXDROID_PKG_DEPENDS="readline,flex"
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--infodir=$LINUXDROID_PREFIX/share/info
--mandir=$LINUXDROID_PREFIX/share/man
--with-readline
"

linuxdroid_step_pre_configure() {
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/bc/libmath.h \
	   $LINUXDROID_PKG_SRCDIR/bc/libmath.h
	touch -d "next hour" $LINUXDROID_PKG_SRCDIR/bc/libmath.h
}
