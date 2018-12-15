MININIX_PKG_HOMEPAGE=https://git-scm.com/
MININIX_PKG_DESCRIPTION="Fast, scalable, distributed revision control system"
# less is required as a pager for git log, and the busybox less does not handle used escape sequences.
MININIX_PKG_DEPENDS="libcurl, less, openssl, pcre2"
MININIX_PKG_VERSION=2.19.2
MININIX_PKG_SHA256=fce9a3a3297db5f3756c4553a2fc1fec209ee08178f8491e76ff4ff8fe7b8be9
MININIX_PKG_SRCURL=https://www.kernel.org/pub/software/scm/git/git-${MININIX_PKG_VERSION}.tar.xz
## This requires a working $MININIX_PREFIX/bin/sh on the host building:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_fread_reads_directories=yes
ac_cv_header_libintl_h=no
ac_cv_snprintf_returns_bogus=no
--with-curl
--without-tcltk
--with-shell=$MININIX_PREFIX/bin/sh
"
# expat is only used by git-http-push for remote lock management over DAV, so disable:
# NO_INSTALL_HARDLINKS to use symlinks instead of hardlinks (which does not work on Android M):
MININIX_PKG_EXTRA_MAKE_ARGS="
NO_NSEC=1
NO_GETTEXT=1
NO_EXPAT=1
NO_INSTALL_HARDLINKS=1
PERL_PATH=$MININIX_PREFIX/bin/perl
USE_LIBPCRE2=1
"
MININIX_PKG_BUILD_IN_SRC="yes"

# Things to remove to save space:
#  bin/git-cvsserver - server emulating CVS
#  bin/git-shell - restricted login shell for Git-only SSH access
MININIX_PKG_RM_AFTER_INSTALL="
bin/git-cvsserver
bin/git-shell
libexec/git-core/git-shell
libexec/git-core/git-cvsserver
share/man/man1/git-cvsserver.1
share/man/man1/git-shell.1
"

mininix_step_pre_configure () {
	# Setup perl so that the build process can execute it:
	rm -f $MININIX_PREFIX/bin/perl
	ln -s `which perl` $MININIX_PREFIX/bin/perl

	# Force fresh perl files (otherwise files from earlier builds
	# remains without bumped modification times, so are not picked
	# up by the package):
	rm -Rf $MININIX_PREFIX/share/git-perl

	# Fixes build if utfcpp is installed:
	CPPFLAGS="-I$MININIX_PKG_SRCDIR $CPPFLAGS"
}

mininix_step_post_make_install () {
	# Installing man requires asciidoc and xmlto, so git uses separate make targets for man pages
	make -j $MININIX_MAKE_PROCESSES install-man

	mkdir -p $MININIX_PREFIX/etc/bash_completion.d/
	cp $MININIX_PKG_SRCDIR/contrib/completion/git-completion.bash \
	   $MININIX_PKG_SRCDIR/contrib/completion/git-prompt.sh \
	   $MININIX_PREFIX/etc/bash_completion.d/

	# Remove the build machine perl setup in mininix_step_pre_configure to avoid it being packaged:
	rm $MININIX_PREFIX/bin/perl

	# Remove clutter:
	rm -Rf $MININIX_PREFIX/lib/*-linux*/perl

	# Remove duplicated binaries in bin/ with symlink to the one in libexec/git-core:
	(cd $MININIX_PREFIX/bin; ln -s -f ../libexec/git-core/git git)
	(cd $MININIX_PREFIX/bin; ln -s -f ../libexec/git-core/git-upload-pack git-upload-pack)
}

mininix_step_post_massage () {
	if [ ! -f libexec/git-core/git-remote-https ]; then
		mininix_error_exit "Git built without https support"
	fi
}
