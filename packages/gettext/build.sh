MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/gettext/
MININIX_PKG_DESCRIPTION="GNU Internationalization utilities"
MININIX_PKG_VERSION=0.19.8.1
MININIX_PKG_SHA256=105556dbc5c3fbbc2aa0edb46d22d055748b6f5c7cd7a8d99f8e7eb84e938be4
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gettext/gettext-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="pcre, liblzma, libxml2, libcroco, ncurses, libunistring"
mininix_step_pre_configure () {
	autoreconf
}
