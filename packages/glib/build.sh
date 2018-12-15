MININIX_PKG_HOMEPAGE=https://developer.gnome.org/glib/
MININIX_PKG_DESCRIPTION="Library providing core building blocks for libraries and applications written in C"
MININIX_PKG_VERSION=2.58.1
MININIX_PKG_SHA256=97d6a9d926b6aa3dfaadad3077cfb43eec74432ab455dff14250c769d526d7d6
MININIX_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib/${MININIX_PKG_VERSION:0:4}/glib-${MININIX_PKG_VERSION}.tar.xz
# libandroid-support to get langinfo.h in include path.
MININIX_PKG_DEPENDS="libffi, pcre, libandroid-support"
MININIX_PKG_RM_AFTER_INSTALL="share/gtk-doc lib/locale share/glib-2.0/gettext share/gdb/auto-load share/glib-2.0/codegen share/glib-2.0/gdb bin/gtester-report bin/glib-gettextize bin/gdbus-codegen"
# Needed by pkg-config for glib-2.0:
MININIX_PKG_DEVPACKAGE_DEPENDS="pcre-dev"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="lib/glib-2.0/include"

# --enable-compile-warnings=no to get rid of format strings causing errors.
# --disable-znodelete to avoid DF_1_NODELETE which most Android 5.0 linkers does not support.
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--cache-file=mininix_configure.cache
--disable-compile-warnings
--disable-gtk-doc
--disable-gtk-doc-html
--disable-libelf
--disable-libmount
--disable-znodelete
--with-pcre=system
"

mininix_step_pre_configure () {
	NOCONFIGURE=1 ./autogen.sh

	# glib checks for __BIONIC__ instead of __ANDROID__:
	CFLAGS="$CFLAGS -D__BIONIC__=1"

	cd $MININIX_PKG_BUILDDIR

	# https://developer.gnome.org/glib/stable/glib-cross-compiling.html
	echo "glib_cv_long_long_format=ll" >> mininix_configure.cache
	echo "glib_cv_stack_grows=no" >> mininix_configure.cache
	echo "glib_cv_uscore=no" >> mininix_configure.cache
	chmod a-w mininix_configure.cache
}
