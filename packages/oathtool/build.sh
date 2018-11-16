LINUXDROID_PKG_HOMEPAGE=http://www.nongnu.org/oath-toolkit/
LINUXDROID_PKG_DESCRIPTION="One-time password components"
LINUXDROID_PKG_VERSION=2.6.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://download.savannah.nongnu.org/releases/oath-toolkit/oath-toolkit-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_SHA256=b03446fa4b549af5ebe4d35d7aba51163442d255660558cd861ebce536824aa0
LINUXDROID_PKG_DEPENDS="xmlsec"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-pam"

linuxdroid_step_pre_configure () {
	if [ "$LINUXDROID_DEBUG" == "true" ]; then
		# When doing debug build, -D_FORTIFY_SOURCE=2 gives this error:
		# /home/builder/.linuxdroid-build/oathtool/src/liboath/usersfile.c:482:46: error: 'umask' called with invalid mode
		#       old_umask = umask (~(S_IRUSR | S_IWUSR));
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}
