MININIX_PKG_HOMEPAGE=https://yarnpkg.com/
MININIX_PKG_DESCRIPTION="Fast, reliable, and secure dependency management"
MININIX_PKG_MAINTAINER="Pierre Rudloff @Rudloff"
MININIX_PKG_DEPENDS="nodejs | nodejs-lts"
MININIX_PKG_VERSION=1.12.3
MININIX_PKG_SHA256=02cd4b589ec22c4bdbd2bc5ebbfd99c5e99b07242ad68a539cb37896b93a24f2
MININIX_PKG_SRCURL=https://yarnpkg.com/downloads/${MININIX_PKG_VERSION}/yarn-v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	cp -r . ${MININIX_PREFIX}/share/yarn/
	ln -f -s ../share/yarn/bin/yarn ${MININIX_PREFIX}/bin/yarn
}
