LINUXDROID_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

LINUXDROID_PKG_HOMEPAGE=http://packages.debian.org/fakeroot
LINUXDROID_PKG_DESCRIPTION="Tool for simulating superuser privileges (with tcp ipc)"
LINUXDROID_PKG_VERSION=1.23
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_${LINUXDROID_PKG_VERSION}.orig.tar.xz
LINUXDROID_PKG_SHA256=009cd6696a931562cf1c212bb57ca441a4a2d45cd32c3190a35c7ae98506f4f6
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-ipc=tcp"

linuxdroid_step_post_make_install() {
	ln -sfr "${LINUXDROID_PREFIX}/lib/libfakeroot-0.so" "${LINUXDROID_PREFIX}/lib/libfakeroot.so"
}
