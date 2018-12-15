MININIX_PKG_HOMEPAGE=https://github.com/JFreegman/toxic
MININIX_PKG_DESCRIPTION="A command line client for Tox"
MININIX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
MININIX_PKG_VERSION=0.8.3
MININIX_PKG_SHA256=97f26ba2c257c10439fd2ff280ca90c37ed225d86f46740a08f02ff2e4459e0e
MININIX_PKG_SRCURL=https://github.com/JFreegman/toxic/archive/v${MININIX_PKG_VERSION}/toxic-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="c-toxcore, libconfig, libcurl, libqrencode, ncurses"
MININIX_PKG_BUILD_IN_SRC=true

mininix_step_make() {
	make \
		PREFIX="${MININIX_PREFIX}" \
		CC="${CC}" \
		PKG_CONFIG="${PKG_CONFIG}" \
		USER_CFLAGS="${CFLAGS}" \
		USER_LDFLAGS="${LDFLAGS}"
}

mininix_step_make_install() {
	make PREFIX="${MININIX_PREFIX}" install
}
