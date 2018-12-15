MININIX_PKG_HOMEPAGE=https://www.dovecot.org
MININIX_PKG_DESCRIPTION="Secure IMAP and POP3 email server"
MININIX_PKG_VERSION=2.2.31
MININIX_PKG_SRCURL=https://www.dovecot.org/releases/2.2/dovecot-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=034be40907748128d65088a4f59789b2f99ae7b33a88974eae0b6a68ece376a1
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_DEPENDS="openssl, libcrypt"
# turning on icu gives undefined reference to __cxa_call_unexpected
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--with-zlib
--with-ssl=openssl
--with-ssldir=$MININIX_PREFIX/etc/tls
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

mininix_step_pre_configure () {
	LDFLAGS="$LDFLAGS -llog"

	for i in `find $MININIX_PKG_SRCDIR/src/director -type f`; do sed 's|\bstruct user\b|struct usertest|g' -i $i; done

	if [ "$MININIX_ARCH" == "aarch64" ]; then
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=yes"
	else
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+="lib_cv_va_val_copy=no"
	fi
}

mininix_step_post_make_install () {
	for binary in doveadm doveconf; do
		mv $MININIX_PREFIX/bin/$binary $MININIX_PREFIX/libexec/dovecot/$binary
		cat > $MININIX_PREFIX/bin/$binary <<HERE
#!$MININIX_PREFIX/bin/sh
export LD_LIBRARY_PATH=$MININIX_PREFIX/lib/dovecot:\$LD_LIBRARY_PATH
exec $MININIX_PREFIX/libexec/dovecot/$binary $@
HERE
		chmod u+x $MININIX_PREFIX/bin/$binary
	done
}
