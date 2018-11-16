LINUXDROID_PKG_HOMEPAGE=https://tox.chat
LINUXDROID_PKG_DESCRIPTION="Backend library for the Tox protocol"
LINUXDROID_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
LINUXDROID_PKG_VERSION=0.2.8
LINUXDROID_PKG_SHA256=47fe125d8558775a03a3ded58e9faa07a01cfecd65257e24b544b4b5698d9362
LINUXDROID_PKG_SRCURL=https://github.com/TokTok/toxcore/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libsodium"
LINUXDROID_PKG_BUILD_IN_SRC=true

linuxdroid_step_configure() {
	linuxdroid_setup_cmake

	cmake \
			-DCMAKE_INSTALL_PREFIX="${LINUXDROID_PREFIX}" \
			-DCMAKE_INSTALL_LIBDIR="${LINUXDROID_PREFIX}/lib" \
			-DBOOTSTRAP_DAEMON=off \
			-DDHT_BOOTSTRAP=off \
			-DBUILD_TOXAV=off \
			-DBUILD_AV_TEST=off
}
