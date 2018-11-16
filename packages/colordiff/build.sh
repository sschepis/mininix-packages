LINUXDROID_PKG_HOMEPAGE=http://www.colordiff.org
LINUXDROID_PKG_DESCRIPTION="Tool to colorize 'diff' output"
LINUXDROID_PKG_VERSION=1.0.18
LINUXDROID_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
LINUXDROID_PKG_SRCURL=http://www.colordiff.org/colordiff-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=29cfecd8854d6e19c96182ee13706b84622d7b256077df19fbd6a5452c30d6e0
LINUXDROID_PKG_DEPENDS="perl"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make() {
	# Skip the 'make' invocation as it only tries to
	# rebuild the documentation.
	continue
}

linuxdroid_step_post_configure() {
	export INSTALL_DIR=${PREFIX}/bin
	export MAN_DIR=${PREFIX}/share/man/man1
	export ETC_DIR=${PREFIX}/etc
}
