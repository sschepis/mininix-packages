LINUXDROID_PKG_HOMEPAGE=https://git-scm.com/
LINUXDROID_PKG_DESCRIPTION="Fast, scalable, distributed revision control system"
# less is required as a pager for git log, and the busybox less does not handle used escape sequences.
LINUXDROID_PKG_DEPENDS="libcurl, less, openssl, pcre2"
LINUXDROID_PKG_VERSION=2.19.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=345056aa9b8084280b1b9fe1374d232dec05a34e8849028a20bfdb56e920dbb5
LINUXDROID_PKG_SRCURL=https://www.kernel.org/pub/software/scm/git/git-${LINUXDROID_PKG_VERSION}.tar.xz
## This requires a working $LINUXDROID_PREFIX/bin/sh on the host building:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fread_reads_directories=yes
ac_cv_header_libintl_h=no
ac_cv_snprintf_returns_bogus=no
--with-curl
--without-tcltk
--with-shell=$LINUXDROID_PREFIX/bin/sh
"
# expat is only used by git-http-push for remote lock management over DAV, so disable:
# NO_INSTALL_HARDLINKS to use symlinks instead of hardlinks (which does not work on Android M):
LINUXDROID_PKG_EXTRA_MAKE_ARGS="
NO_NSEC=1
NO_GETTEXT=1
NO_EXPAT=1
NO_INSTALL_HARDLINKS=1
PERL_PATH=$LINUXDROID_PREFIX/bin/perl
USE_LIBPCRE2=1
"
LINUXDROID_PKG_BUILD_IN_SRC="yes"

# Things to remove to save space:
#  bin/git-cvsserver - server emulating CVS
#  bin/git-shell - restricted login shell for Git-only SSH access
LINUXDROID_PKG_RM_AFTER_INSTALL="
bin/git-cvsserver
bin/git-shell
libexec/git-core/git-shell
libexec/git-core/git-cvsserver
share/man/man1/git-cvsserver.1
share/man/man1/git-shell.1
"

linuxdroid_step_pre_configure () {
	# Setup perl so that the build process can execute it:
	rm -f $LINUXDROID_PREFIX/bin/perl
	ln -s `which perl` $LINUXDROID_PREFIX/bin/perl

	# Force fresh perl files (otherwise files from earlier builds
	# remains without bumped modification times, so are not picked
	# up by the package):
	rm -Rf $LINUXDROID_PREFIX/share/git-perl

	# Fixes build if utfcpp is installed:
	CPPFLAGS="-I$LINUXDROID_PKG_SRCDIR $CPPFLAGS"
}

linuxdroid_step_post_make_install () {
	# Installing man requires asciidoc and xmlto, so git uses separate make targets for man pages
	make -j $LINUXDROID_MAKE_PROCESSES install-man

	mkdir -p $LINUXDROID_PREFIX/etc/bash_completion.d/
	cp $LINUXDROID_PKG_SRCDIR/contrib/completion/git-completion.bash \
	   $LINUXDROID_PKG_SRCDIR/contrib/completion/git-prompt.sh \
	   $LINUXDROID_PREFIX/etc/bash_completion.d/

	# Remove the build machine perl setup in linuxdroid_step_pre_configure to avoid it being packaged:
	rm $LINUXDROID_PREFIX/bin/perl

	# Remove clutter:
	rm -Rf $LINUXDROID_PREFIX/lib/*-linux*/perl

	# Remove duplicated binaries in bin/ with symlink to the one in libexec/git-core:
	(cd $LINUXDROID_PREFIX/bin; ln -s -f ../libexec/git-core/git git)
	(cd $LINUXDROID_PREFIX/bin; ln -s -f ../libexec/git-core/git-upload-pack git-upload-pack)
}

linuxdroid_step_post_massage () {
	if [ ! -f libexec/git-core/git-remote-https ]; then
		linuxdroid_error_exit "Git built without https support"
	fi
}
