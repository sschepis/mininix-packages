LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gettext/
LINUXDROID_PKG_DESCRIPTION="GNU Internationalization utilities"
LINUXDROID_PKG_VERSION=0.19.8.1
LINUXDROID_PKG_SHA256=105556dbc5c3fbbc2aa0edb46d22d055748b6f5c7cd7a8d99f8e7eb84e938be4
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gettext/gettext-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="pcre, liblzma, libxml2, libcroco, ncurses, libunistring"
linuxdroid_step_pre_configure () {
	autoreconf
}
