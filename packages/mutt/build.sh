LINUXDROID_PKG_HOMEPAGE=http://www.mutt.org/
LINUXDROID_PKG_DESCRIPTION="Mail client with patches from neomutt"
LINUXDROID_PKG_VERSION=1.10.1
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SHA256=734a3883158ec3d180cf6538d8bd7f685ce641d2cdef657aa0038f76e79a54a0
LINUXDROID_PKG_SRCURL=ftp://ftp.mutt.org/pub/mutt/mutt-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses, gdbm, openssl, libsasl, mime-support"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
mutt_cv_c99_snprintf=yes
mutt_cv_c99_vsnprintf=yes
--disable-gpgme
--enable-compressed
--enable-hcache
--enable-imap
--enable-pop
--enable-sidebar
--enable-smtp
--with-exec-shell=$LINUXDROID_PREFIX/bin/sh
--with-mailpath=$LINUXDROID_PREFIX/var/mail
--without-idn
--with-sasl
--with-ssl
"
LINUXDROID_PKG_RM_AFTER_INSTALL="
bin/flea
bin/muttbug
share/man/man1/muttbug.1
share/man/man1/flea.1
etc/mime.types
"
LINUXDROID_PKG_CONFFILES="etc/Muttrc"

linuxdroid_step_post_configure () {
	# Build wants to run mutt_md5 and makedoc:
	gcc -DHAVE_STDINT_H -DMD5UTIL $LINUXDROID_PKG_SRCDIR/md5.c -o $LINUXDROID_PKG_BUILDDIR/mutt_md5
	gcc -DHAVE_STRERROR $LINUXDROID_PKG_SRCDIR/doc/makedoc.c -o $LINUXDROID_PKG_BUILDDIR/doc/makedoc
	touch -d "next hour" $LINUXDROID_PKG_BUILDDIR/mutt_md5 $LINUXDROID_PKG_BUILDDIR/doc/makedoc
}

linuxdroid_step_post_make_install () {
	cp $LINUXDROID_PKG_SRCDIR/doc/mutt.man $LINUXDROID_PREFIX/share/man/man1/mutt.1.man
	mkdir -p $LINUXDROID_PREFIX/share/examples/mutt/
	cp $LINUXDROID_PKG_SRCDIR/contrib/gpg.rc $LINUXDROID_PREFIX/share/examples/mutt/gpg.rc
	mv $LINUXDROID_PREFIX/etc/mime.types.dist $LINUXDROID_PREFIX/etc/mime.types
	mv $LINUXDROID_PREFIX/etc/Muttrc.dist $LINUXDROID_PREFIX/etc/Muttrc
}
