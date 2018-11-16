LINUXDROID_PKG_HOMEPAGE=https://github.com/Parchive/par2cmdline
LINUXDROID_PKG_DESCRIPTION="par2cmdline is a PAR 2.0 compatible file verification and repair tool."
LINUXDROID_PKG_VERSION=0.8.0
LINUXDROID_PKG_SHA256=461b45627a0d800061657b2d800c432c7d1c86c859b40a3ced35a0cc6a85faca
LINUXDROID_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
LINUXDROID_PKG_SRCURL=https://github.com/Parchive/par2cmdline/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	if [ $LINUXDROID_ARCH = "i686" ]; then
		sed -i 's/LDADD = -lstdc++/LDADD = -lstdc++ -latomic/' $LINUXDROID_PKG_SRCDIR/Makefile.am
	fi
	aclocal
	automake --add-missing
	autoconf
}
