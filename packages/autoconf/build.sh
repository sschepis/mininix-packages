MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/autoconf/autoconf.html
MININIX_PKG_DESCRIPTION="Creator of shell scripts to configure source code packages"
MININIX_PKG_VERSION=2.69
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/autoconf/autoconf-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684
MININIX_PKG_DEPENDS="m4, make, perl"
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_post_extract_package () {
	perl -p -i -e "s|/bin/sh|$MININIX_PREFIX/bin/sh|" lib/*/*.m4
}

mininix_step_post_massage () {
	perl -p -i -e "s|/usr/bin/m4|$MININIX_PREFIX/bin/m4|" bin/*
	perl -p -i -e "s|CONFIG_SHELL-/bin/sh|CONFIG_SHELL-$MININIX_PREFIX/bin/sh|" bin/autoconf
}
