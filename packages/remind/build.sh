MININIX_PKG_HOMEPAGE=https://dianne.skoll.ca/projects/remind/
MININIX_PKG_DESCRIPTION="Sophisticated calendar and alarm program"
MININIX_PKG_VERSION=3.1.16
MININIX_PKG_SHA256=eeb79bd4019d23a033fe3e86c672d960399db6a27c747e5b466ad55831dfca93
MININIX_PKG_SRCURL=https://dianne.skoll.ca/projects/remind/download/remind-0${MININIX_PKG_VERSION:0:1}.0${MININIX_PKG_VERSION:2:1}.${MININIX_PKG_VERSION:4:2}.tar.gz
MININIX_PKG_DEPENDS="libandroid-glob"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_RM_AFTER_INSTALL="bin/tkremind share/man/man1/tkremind.1 bin/cm2rem.tcl share/man/man1/cm2rem.1"

mininix_step_pre_configure () {
	LDFLAGS+=" -landroid-glob"
}
