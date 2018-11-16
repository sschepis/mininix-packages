LINUXDROID_PKG_HOMEPAGE=https://yarnpkg.com/
LINUXDROID_PKG_DESCRIPTION="Fast, reliable, and secure dependency management"
LINUXDROID_PKG_MAINTAINER="Pierre Rudloff @Rudloff"
LINUXDROID_PKG_DEPENDS="nodejs | nodejs-lts"
LINUXDROID_PKG_VERSION=1.12.3
LINUXDROID_PKG_SHA256=02cd4b589ec22c4bdbd2bc5ebbfd99c5e99b07242ad68a539cb37896b93a24f2
LINUXDROID_PKG_SRCURL=https://yarnpkg.com/downloads/${LINUXDROID_PKG_VERSION}/yarn-v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
	cp -r . ${LINUXDROID_PREFIX}/share/yarn/
	ln -f -s ../share/yarn/bin/yarn ${LINUXDROID_PREFIX}/bin/yarn
}
