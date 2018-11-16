LINUXDROID_PKG_HOMEPAGE=https://developer.gnome.org/glib/
LINUXDROID_PKG_DESCRIPTION="Library providing core building blocks for libraries and applications written in C"
LINUXDROID_PKG_VERSION=2.58.1
LINUXDROID_PKG_SHA256=97d6a9d926b6aa3dfaadad3077cfb43eec74432ab455dff14250c769d526d7d6
LINUXDROID_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib/${LINUXDROID_PKG_VERSION:0:4}/glib-${LINUXDROID_PKG_VERSION}.tar.xz
# libandroid-support to get langinfo.h in include path.
LINUXDROID_PKG_DEPENDS="libffi, pcre, libandroid-support"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/gtk-doc lib/locale share/glib-2.0/gettext share/gdb/auto-load share/glib-2.0/codegen share/glib-2.0/gdb bin/gtester-report bin/glib-gettextize bin/gdbus-codegen"
# Needed by pkg-config for glib-2.0:
LINUXDROID_PKG_DEVPACKAGE_DEPENDS="pcre-dev"
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="lib/glib-2.0/include"

# --enable-compile-warnings=no to get rid of format strings causing errors.
# --disable-znodelete to avoid DF_1_NODELETE which most Android 5.0 linkers does not support.
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--cache-file=linuxdroid_configure.cache
--disable-compile-warnings
--disable-gtk-doc
--disable-gtk-doc-html
--disable-libelf
--disable-libmount
--disable-znodelete
--with-pcre=system
"

linuxdroid_step_pre_configure () {
	NOCONFIGURE=1 ./autogen.sh

	# glib checks for __BIONIC__ instead of __ANDROID__:
	CFLAGS="$CFLAGS -D__BIONIC__=1"

	cd $LINUXDROID_PKG_BUILDDIR

	# https://developer.gnome.org/glib/stable/glib-cross-compiling.html
	echo "glib_cv_long_long_format=ll" >> linuxdroid_configure.cache
	echo "glib_cv_stack_grows=no" >> linuxdroid_configure.cache
	echo "glib_cv_uscore=no" >> linuxdroid_configure.cache
	chmod a-w linuxdroid_configure.cache
}
