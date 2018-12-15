MININIX_PKG_HOMEPAGE=http://www.nongnu.org/oath-toolkit/
MININIX_PKG_DESCRIPTION="One-time password components"
MININIX_PKG_VERSION=2.6.2
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=http://download.savannah.nongnu.org/releases/oath-toolkit/oath-toolkit-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=b03446fa4b549af5ebe4d35d7aba51163442d255660558cd861ebce536824aa0
MININIX_PKG_DEPENDS="xmlsec"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-pam"

mininix_step_pre_configure () {
	if [ "$MININIX_DEBUG" == "true" ]; then
		# When doing debug build, -D_FORTIFY_SOURCE=2 gives this error:
		# /home/builder/.mininix-build/oathtool/src/liboath/usersfile.c:482:46: error: 'umask' called with invalid mode
		#       old_umask = umask (~(S_IRUSR | S_IWUSR));
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}
