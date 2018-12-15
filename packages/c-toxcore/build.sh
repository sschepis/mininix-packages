MININIX_PKG_HOMEPAGE=https://tox.chat
MININIX_PKG_DESCRIPTION="Backend library for the Tox protocol"
MININIX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
MININIX_PKG_VERSION=0.2.8
MININIX_PKG_SHA256=47fe125d8558775a03a3ded58e9faa07a01cfecd65257e24b544b4b5698d9362
MININIX_PKG_SRCURL=https://github.com/TokTok/toxcore/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libsodium"
MININIX_PKG_BUILD_IN_SRC=true

mininix_step_configure() {
	mininix_setup_cmake

	cmake \
			-DCMAKE_INSTALL_PREFIX="${MININIX_PREFIX}" \
			-DCMAKE_INSTALL_LIBDIR="${MININIX_PREFIX}/lib" \
			-DBOOTSTRAP_DAEMON=off \
			-DDHT_BOOTSTRAP=off \
			-DBUILD_TOXAV=off \
			-DBUILD_AV_TEST=off
}
