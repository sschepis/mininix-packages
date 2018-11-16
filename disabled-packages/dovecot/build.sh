LINUXDROID_PKG_HOMEPAGE=https://www.dovecot.org
LINUXDROID_PKG_DESCRIPTION="Secure IMAP and POP3 email server"
LINUXDROID_PKG_VERSION=2.2.31
LINUXDROID_PKG_SRCURL=https://www.dovecot.org/releases/2.2/dovecot-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_SHA256=034be40907748128d65088a4f59789b2f99ae7b33a88974eae0b6a68ece376a1
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_DEPENDS="openssl, libcrypt"
# turning on icu gives undefined reference to __cxa_call_unexpected
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--with-zlib
--with-ssl=openssl
--with-ssldir=$LINUXDROID_PREFIX/etc/tls
--without-icu
--without-shadow
i_cv_epoll_works=yes
i_cv_posix_fallocate_works=yes
i_cv_signed_size_t=no
i_cv_gmtime_max_time_t=40
i_cv_signed_time_t=yes
i_cv_mmap_plays_with_write=yes
i_cv_fd_passing=yes
i_cv_c99_vsnprintf=yes
lib_cv_va_copy=yes
lib_cv___va_copy=yes
"

linuxdroid_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog"

	for i in `find $LINUXDROID_PKG_SRCDIR/src/director -type f`; do sed 's|\bstruct user\b|struct usertest|g' -i $i; done

	if [ "$LINUXDROID_ARCH" == "aarch64" ]; then
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=yes"
	else
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=no"
	fi
}

linuxdroid_step_post_make_install () {
	for binary in doveadm doveconf; do
		mv $LINUXDROID_PREFIX/bin/$binary $LINUXDROID_PREFIX/libexec/dovecot/$binary
		cat > $LINUXDROID_PREFIX/bin/$binary <<HERE
#!$LINUXDROID_PREFIX/bin/sh
export LD_LIBRARY_PATH=$LINUXDROID_PREFIX/lib/dovecot:\$LD_LIBRARY_PATH
exec $LINUXDROID_PREFIX/libexec/dovecot/$binary $@
HERE
		chmod u+x $LINUXDROID_PREFIX/bin/$binary
	done
}
