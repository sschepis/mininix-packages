MININIX_PKG_HOMEPAGE=http://www.colordiff.org
MININIX_PKG_DESCRIPTION="Tool to colorize 'diff' output"
MININIX_PKG_VERSION=1.0.18
MININIX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MININIX_PKG_SRCURL=http://www.colordiff.org/colordiff-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=29cfecd8854d6e19c96182ee13706b84622d7b256077df19fbd6a5452c30d6e0
MININIX_PKG_DEPENDS="perl"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make() {
	# Skip the 'make' invocation as it only tries to
	# rebuild the documentation.
	continue
}

mininix_step_post_configure() {
	export INSTALL_DIR=${PREFIX}/bin
	export MAN_DIR=${PREFIX}/share/man/man1
	export ETC_DIR=${PREFIX}/etc
}
