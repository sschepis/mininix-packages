MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/libgcrypt/
MININIX_PKG_DESCRIPTION="General purpose cryptographic library based on the code from GnuPG"
MININIX_PKG_VERSION=1.8.4
MININIX_PKG_SHA256=f638143a0672628fde0cad745e9b14deb85dffb175709cacc1f4fe24b93f2227
MININIX_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="libgpg-error"
MININIX_PKG_DEVPACKAGE_DEPENDS="libgpg-error-dev"
# configure tries to detect pthreads by linking with -lpthread, which does not exist on Android:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pthread_pthread_create=yes
--disable-jent-support
"

mininix_step_pre_configure () {
	# libgcrypt uses syslog, which we redirect to android logging:
	LDFLAGS="$LDFLAGS -llog"

	CFLAGS+=" -no-integrated-as"
	if [ $MININIX_ARCH = "arm" ]; then
		# See http://marc.info/?l=gnupg-devel&m=139136972631909&w=3
		CFLAGS+=" -mno-unaligned-access"
		# Avoid text relocations:
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" gcry_cv_gcc_inline_asm_neon=no"
	elif [ $MININIX_ARCH = "i686" ] || [ $MININIX_ARCH = "x86_64" ]; then
		# Fix i686 android build, also in https://bugzilla.gnome.org/show_bug.cgi?id=724050
		MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}
