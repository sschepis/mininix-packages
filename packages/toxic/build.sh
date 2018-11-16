LINUXDROID_PKG_HOMEPAGE=https://github.com/JFreegman/toxic
LINUXDROID_PKG_DESCRIPTION="A command line client for Tox"
LINUXDROID_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
LINUXDROID_PKG_VERSION=0.8.3
LINUXDROID_PKG_SHA256=97f26ba2c257c10439fd2ff280ca90c37ed225d86f46740a08f02ff2e4459e0e
LINUXDROID_PKG_SRCURL=https://github.com/JFreegman/toxic/archive/v${LINUXDROID_PKG_VERSION}/toxic-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="c-toxcore, libconfig, libcurl, libqrencode, ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=true

linuxdroid_step_make() {
	make \
		PREFIX="${LINUXDROID_PREFIX}" \
		CC="${CC}" \
		PKG_CONFIG="${PKG_CONFIG}" \
		USER_CFLAGS="${CFLAGS}" \
		USER_LDFLAGS="${LDFLAGS}"
}

linuxdroid_step_make_install() {
	make PREFIX="${LINUXDROID_PREFIX}" install
}
