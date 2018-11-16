LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/libgcrypt/
LINUXDROID_PKG_DESCRIPTION="General purpose cryptographic library based on the code from GnuPG"
LINUXDROID_PKG_VERSION=1.8.4
LINUXDROID_PKG_SHA256=f638143a0672628fde0cad745e9b14deb85dffb175709cacc1f4fe24b93f2227
LINUXDROID_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="libgpg-error"
LINUXDROID_PKG_DEVPACKAGE_DEPENDS="libgpg-error-dev"
# configure tries to detect pthreads by linking with -lpthread, which does not exist on Android:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pthread_pthread_create=yes
--disable-jent-support
"

linuxdroid_step_pre_configure () {
	# libgcrypt uses syslog, which we redirect to android logging:
	LDFLAGS="$LDFLAGS -llog"

	CFLAGS+=" -no-integrated-as"
	if [ $LINUXDROID_ARCH = "arm" ]; then
		# See http://marc.info/?l=gnupg-devel&m=139136972631909&w=3
		CFLAGS+=" -mno-unaligned-access"
		# Avoid text relocations:
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" gcry_cv_gcc_inline_asm_neon=no"
	elif [ $LINUXDROID_ARCH = "i686" ] || [ $LINUXDROID_ARCH = "x86_64" ]; then
		# Fix i686 android build, also in https://bugzilla.gnome.org/show_bug.cgi?id=724050
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-asm"
	fi
}
