LINUXDROID_PKG_HOMEPAGE=https://www.graphviz.org/
LINUXDROID_PKG_DESCRIPTION="Rich set of graph drawing tools"
LINUXDROID_PKG_MAINTAINER="Dustin DeWeese @HackerFoo"
LINUXDROID_PKG_VERSION=2.40.1
LINUXDROID_PKG_REVISION=4
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/graphviz-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_SHA256=ca5218fade0204d59947126c38439f432853543b0818d9d728c589dfe7f3a421
LINUXDROID_PKG_DEPENDS="libandroid-glob,libcairo,pango,libexpat,libltdl,librsvg,libgd"
LINUXDROID_PKG_BUILD_DEPENDS="libtool"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
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
--with-ltdl-include=$LINUXDROID_PREFIX/include
--with-ltdl-lib=$LINUXDROID_PREFIX/lib
--with-pangocairo=yes
--with-pic
--with-poppler=no
--with-x=no
"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/*-config share/man/man1/*-config.1"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CPPFLAGS+=" -D_typ_ssize_t=1"
}

linuxdroid_step_post_make_install() {
	# Some binaries (dot_builtins, gvpack) links against these:
	cd $LINUXDROID_PREFIX/lib
	for lib in graphviz/*.so.*; do
		ln -s -f $lib `basename $lib`
	done
}

linuxdroid_step_create_debscripts () {
	echo "#!$LINUXDROID_PREFIX/bin/sh" > postinst
	echo "dot -c" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}
