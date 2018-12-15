MININIX_PKG_HOMEPAGE=https://github.com/Parchive/par2cmdline
MININIX_PKG_DESCRIPTION="par2cmdline is a PAR 2.0 compatible file verification and repair tool."
MININIX_PKG_VERSION=0.8.0
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=461b45627a0d800061657b2d800c432c7d1c86c859b40a3ced35a0cc6a85faca
MININIX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MININIX_PKG_SRCURL=https://github.com/Parchive/par2cmdline/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	if [ $MININIX_ARCH = "i686" ]; then
		sed -i 's/LDADD = -lstdc++/LDADD = -lstdc++ -latomic/' $MININIX_PKG_SRCDIR/Makefile.am
	fi
	aclocal
	automake --add-missing
	autoconf
}
