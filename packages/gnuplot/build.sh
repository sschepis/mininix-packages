MININIX_PKG_HOMEPAGE=http://gnuplot.info/
MININIX_PKG_DESCRIPTION="Command-line driven graphing utility"
MININIX_PKG_VERSION=5.2.5
MININIX_PKG_SHA256=039db2cce62ddcfd31a6696fe576f4224b3bc3f919e66191dfe2cdb058475caa
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/gnuplot/gnuplot/${MININIX_PKG_VERSION}/gnuplot-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-x --with-lua=no --with-bitmap-terminals"
MININIX_PKG_DEPENDS="libandroid-support, readline, pango, libgd"
MININIX_PKG_HOSTBUILD=yes

mininix_step_host_build() {
	"$MININIX_PKG_SRCDIR/configure"
	make -C docs/ gnuplot.gih
}

mininix_step_post_make_install() {
	mkdir -p $MININIX_PREFIX/share/gnuplot/5.2/

	cp $MININIX_PKG_HOSTBUILD_DIR/docs/gnuplot.gih \
	   $MININIX_PREFIX/share/gnuplot/5.2/gnuplot.gih
}
