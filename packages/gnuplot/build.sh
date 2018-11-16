LINUXDROID_PKG_HOMEPAGE=http://gnuplot.info/
LINUXDROID_PKG_DESCRIPTION="Command-line driven graphing utility"
LINUXDROID_PKG_VERSION=5.2.5
LINUXDROID_PKG_SHA256=039db2cce62ddcfd31a6696fe576f4224b3bc3f919e66191dfe2cdb058475caa
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/project/gnuplot/gnuplot/${LINUXDROID_PKG_VERSION}/gnuplot-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--without-x --with-lua=no --with-bitmap-terminals"
LINUXDROID_PKG_DEPENDS="libandroid-support, readline, pango, libgd"
LINUXDROID_PKG_HOSTBUILD=yes

linuxdroid_step_host_build() {
	"$LINUXDROID_PKG_SRCDIR/configure"
	make -C docs/ gnuplot.gih
}

linuxdroid_step_post_make_install() {
	mkdir -p $LINUXDROID_PREFIX/share/gnuplot/5.2/

	cp $LINUXDROID_PKG_HOSTBUILD_DIR/docs/gnuplot.gih \
	   $LINUXDROID_PREFIX/share/gnuplot/5.2/gnuplot.gih
}
