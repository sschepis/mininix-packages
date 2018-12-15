MININIX_PKG_HOMEPAGE=https://www.graphviz.org/
MININIX_PKG_DESCRIPTION="Rich set of graph drawing tools"
MININIX_PKG_MAINTAINER="Dustin DeWeese @HackerFoo"
MININIX_PKG_VERSION=2.40.1
MININIX_PKG_REVISION=4
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/graphviz-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=ca5218fade0204d59947126c38439f432853543b0818d9d728c589dfe7f3a421
MININIX_PKG_DEPENDS="libandroid-glob,libcairo,pango,libexpat,libltdl,librsvg,libgd"
MININIX_PKG_BUILD_DEPENDS="libtool"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-guile=no
--enable-java=no
--enable-lua=no
--enable-ocaml=no
--enable-perl=no
--enable-php=no
--enable-python=no
--enable-r=no
--enable-ruby=no
--enable-sharp=no
--enable-swig=no
--enable-tcl=no
--with-ltdl-include=$MININIX_PREFIX/include
--with-ltdl-lib=$MININIX_PREFIX/lib
--with-pangocairo=yes
--with-pic
--with-poppler=no
--with-x=no
"
MININIX_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"

mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CPPFLAGS+=" -D_typ_ssize_t=1"
}

mininix_step_post_make_install() {
	# Some binaries (dot_builtins, gvpack) links against these:
	cd $MININIX_PREFIX/lib
	for lib in graphviz/*.so.*; do
		ln -s -f $lib `basename $lib`
	done
}

mininix_step_create_debscripts () {
	echo "#!$MININIX_PREFIX/bin/sh" > postinst
	echo "dot -c" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
