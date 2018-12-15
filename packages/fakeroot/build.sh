MININIX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

MININIX_PKG_HOMEPAGE=http://packages.debian.org/fakeroot
MININIX_PKG_DESCRIPTION="Tool for simulating superuser privileges (with tcp ipc)"
MININIX_PKG_VERSION=1.23
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_${MININIX_PKG_VERSION}.orig.tar.xz
MININIX_PKG_SHA256=009cd6696a931562cf1c212bb57ca441a4a2d45cd32c3190a35c7ae98506f4f6
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-ipc=tcp"

mininix_step_post_make_install() {
	ln -sfr "${MININIX_PREFIX}/lib/libfakeroot-0.so" "${MININIX_PREFIX}/lib/libfakeroot.so"
}
