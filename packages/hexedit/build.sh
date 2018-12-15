MININIX_PKG_HOMEPAGE=http://rigaux.org/hexedit.html
MININIX_PKG_DESCRIPTION="view and edit files in hexadecimal or in ASCII"
MININIX_PKG_VERSION=1.4.2
MININIX_PKG_SHA256=c81ffb36af9243aefc0887e33dd8e41c4b22d091f1f27d413cbda443b0440d66
MININIX_PKG_SRCURL=https://github.com/pixel/hexedit/archive/$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	./autogen.sh
}
