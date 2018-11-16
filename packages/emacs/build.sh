LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/emacs/
LINUXDROID_PKG_DESCRIPTION="Extensible, customizable text editor-and more"
LINUXDROID_PKG_VERSION=26.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=1cf4fc240cd77c25309d15e18593789c8dbfba5c2b44d8f77c886542300fd32c
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/emacs/emacs-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="ncurses, gnutls, libxml2"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-autodepend
--with-gif=no
--with-gnutls
--with-jpeg=no
--without-gconf
--without-gsettings
--without-lcms2
--without-x
--with-png=no
--with-tiff=no
--with-xml2
--with-xpm=no
"
# Ensure use of system malloc:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_sanitize_address=yes"
# Prevent configure from adding -nopie:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" emacs_cv_prog_cc_no_pie=no"
# Prevent linking against libelf:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_elf_elf_begin=no"
# implemented using dup3(), which fails if oldfd == newfd
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" gl_cv_func_dup2_works=no"
# disable setrlimit function to make linuxdroid-am work from within emacs
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_setrlimit=no"
LINUXDROID_PKG_HOSTBUILD=yes
LINUXDROID_PKG_KEEP_INFOPAGES=yes

# Remove some irrelevant files:
LINUXDROID_PKG_RM_AFTER_INSTALL="share/icons share/emacs/${LINUXDROID_PKG_VERSION}/etc/images share/applications/emacs.desktop share/emacs/${LINUXDROID_PKG_VERSION}/etc/emacs.desktop share/emacs/${LINUXDROID_PKG_VERSION}/etc/emacs.icon bin/grep-changelog share/man/man1/grep-changelog.1.gz share/emacs/${LINUXDROID_PKG_VERSION}/etc/refcards share/emacs/${LINUXDROID_PKG_VERSION}/etc/tutorials/TUTORIAL.*"

# Remove ctags from the emacs package to prevent conflicting with
# the Universal Ctags from the 'ctags' package (the bin/etags
# program still remain in the emacs package):
LINUXDROID_PKG_RM_AFTER_INSTALL+=" bin/ctags share/man/man1/ctags.1 share/man/man1/ctags.1.gz"

linuxdroid_step_post_extract_package () {
	# XXX: We have to start with new host build each time
	#      to avoid build error when cross compiling.
	rm -Rf $LINUXDROID_PKG_HOSTBUILD_DIR

	# Linuxdroid only use info pages for emacs. Remove the info directory
	# to get a clean Info directory file dir.
	rm -Rf $LINUXDROID_PREFIX/share/info

	# We cannot run a dumped emacs on Android 5.0+ due to the pie requirement.
	# Also, the native emacs we build (bootstrap-emacs) cannot used dumps when
	# building inside docker: https://github.com/docker/docker/issues/22801
	export CANNOT_DUMP=yes
}

linuxdroid_step_host_build () {
	# Build a bootstrap-emacs binary to be used in linuxdroid_step_post_configure.
	local NATIVE_PREFIX=$LINUXDROID_PKG_TMPDIR/emacs-native
	mkdir -p $NATIVE_PREFIX/share/emacs/$LINUXDROID_PKG_VERSION
	ln -s $LINUXDROID_PKG_SRCDIR/lisp $NATIVE_PREFIX/share/emacs/$LINUXDROID_PKG_VERSION/lisp

	$LINUXDROID_PKG_SRCDIR/configure --prefix=$NATIVE_PREFIX --without-all --with-x-toolkit=no
	make -j $LINUXDROID_MAKE_PROCESSES
}

linuxdroid_step_post_configure () {
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/src/bootstrap-emacs $LINUXDROID_PKG_BUILDDIR/src/bootstrap-emacs
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/lib-src/make-docfile $LINUXDROID_PKG_BUILDDIR/lib-src/make-docfile
	# Update timestamps so that the binaries does not get rebuilt:
	touch -d "next hour" $LINUXDROID_PKG_BUILDDIR/src/bootstrap-emacs $LINUXDROID_PKG_BUILDDIR/lib-src/make-docfile
}

linuxdroid_step_post_make_install () {
	cp $LINUXDROID_PKG_BUILDER_DIR/site-init.el $LINUXDROID_PREFIX/share/emacs/${LINUXDROID_PKG_VERSION}/lisp/emacs-lisp/
}
