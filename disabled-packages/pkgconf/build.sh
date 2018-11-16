LINUXDROID_PKG_HOMEPAGE=http://pkgconf.org
LINUXDROID_PKG_DESCRIPTION="Program which helps to configure compiler and linker flags for development frameworks"
LINUXDROID_PKG_VERSION=1.5.3
LINUXDROID_PKG_SHA256=45b76f5037379b1e24b788379c74f31fc4f060b272a08bdda9e558c120e9f3b6
LINUXDROID_PKG_SRCURL=https://github.com/pkgconf/pkgconf/archive/pkgconf-$LINUXDROID_PKG_VERSION.tar.gz

linuxdroid_step_pre_configure() {
	./autogen.sh
}
