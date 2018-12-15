MININIX_PKG_HOMEPAGE=http://www.mutt.org/
MININIX_PKG_DESCRIPTION="Mail client with patches from neomutt"
MININIX_PKG_VERSION=1.11.0
MININIX_PKG_SHA256=92c9261933809fed34d66469cb83c7f83bb29f721cd48d608c40cafd299c10e3
MININIX_PKG_SRCURL=ftp://ftp.mutt.org/pub/mutt/mutt-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, ncurses, gdbm, openssl, libsasl, mime-support"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
mutt_cv_c99_snprintf=yes
mutt_cv_c99_vsnprintf=yes
--disable-gpgme
--enable-compressed
--enable-hcache
--enable-imap
--enable-pop
--enable-sidebar
--enable-smtp
--with-exec-shell=$MININIX_PREFIX/bin/sh
--with-mailpath=$MININIX_PREFIX/var/mail
--without-idn
--with-sasl
--with-ssl
"
MININIX_PKG_RM_AFTER_INSTALL="
bin/flea
bin/muttbug
share/man/man1/muttbug.1
share/man/man1/flea.1
etc/mime.types
"
MININIX_PKG_CONFFILES="etc/Muttrc"

mininix_step_post_configure () {
	# Build wants to run mutt_md5 and makedoc:
	gcc -DHAVE_STDINT_H -DMD5UTIL $MININIX_PKG_SRCDIR/md5.c -o $MININIX_PKG_BUILDDIR/mutt_md5
	gcc -DHAVE_STRERROR $MININIX_PKG_SRCDIR/doc/makedoc.c -o $MININIX_PKG_BUILDDIR/doc/makedoc
	touch -d "next hour" $MININIX_PKG_BUILDDIR/mutt_md5 $MININIX_PKG_BUILDDIR/doc/makedoc
}

mininix_step_post_make_install () {
	cp $MININIX_PKG_SRCDIR/doc/mutt.man $MININIX_PREFIX/share/man/man1/mutt.1.man
	mkdir -p $MININIX_PREFIX/share/examples/mutt/
	cp $MININIX_PKG_SRCDIR/contrib/gpg.rc $MININIX_PREFIX/share/examples/mutt/gpg.rc
	mv $MININIX_PREFIX/etc/mime.types.dist $MININIX_PREFIX/etc/mime.types
	mv $MININIX_PREFIX/etc/Muttrc.dist $MININIX_PREFIX/etc/Muttrc
}
