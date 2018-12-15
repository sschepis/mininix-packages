MININIX_PKG_HOMEPAGE=https://vifm.info/
MININIX_PKG_DESCRIPTION="File manager with vi like keybindings"
MININIX_PKG_API_LEVEL=24
MININIX_PKG_VERSION=0.10
MININIX_PKG_SHA256=e5681c9e560e23d9deeec3b5b12e0ccad82612d9592c00407f3dd75cf5066548
MININIX_PKG_SRCURL=https://github.com/vifm/vifm/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="ncurses, file"

mininix_step_pre_configure() {
	autoreconf -if
	if [ "$MININIX_DEBUG" == "true" ]; then
		# Debug build fails with:
		# /home/builder/.mininix-build/vifm/src/src/fops_common.c:745:27: error: 'umask' called with invalid mode
		#      saved_umask = umask(~0600);
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}
